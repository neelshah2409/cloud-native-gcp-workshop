#!/usr/bin/env bash
set -e

export PROJECT_ID=$(gcloud config get-value project)
export REGION="us-central1"
export REPO_NAME="workshop-repo"
export CLUSTER_NAME="workshop-cluster"

echo "==> Configuring Project: ${PROJECT_ID} in ${REGION}..."

# 1. Enable Required APIs
echo "==> Enabling APIs..."
gcloud services enable \
    artifactregistry.googleapis.com \
    cloudbuild.googleapis.com \
    run.googleapis.com \
    container.googleapis.com \
    clouddeploy.googleapis.com

# 2. Create Artifact Registry
echo "==> Creating Artifact Registry Docker repository..."
gcloud artifacts repositories create ${REPO_NAME} \
    --repository-format=docker \
    --location=${REGION} \
    --description="Cloud-native workshop container images" 2>/dev/null || echo "Repository already exists."

# 3. Create GKE Autopilot Cluster
echo "==> Creating GKE Autopilot Cluster (${CLUSTER_NAME})..."
gcloud container clusters create-auto ${CLUSTER_NAME} \
    --region=${REGION} 2>/dev/null || echo "Cluster already exists or is creating."

# 4. IAM Permissions for Cloud Deploy execution
echo "==> Configuring Service Account permissions..."
PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format='value(projectNumber)')
DEFAULT_SA="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${DEFAULT_SA}" \
    --role="roles/clouddeploy.jobRunner" --quiet

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${DEFAULT_SA}" \
    --role="roles/container.developer" --quiet

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${DEFAULT_SA}" \
    --role="roles/run.developer" --quiet

echo "==> Setup completed successfully!"
