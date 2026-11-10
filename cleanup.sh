#!/usr/bin/env bash
set -e

export REGION="us-central1"
export REPO_NAME="workshop-repo"
export CLUSTER_NAME="workshop-cluster"

echo "==> Cleaning up workshop resources..."

# 1. Delete GKE Autopilot Cluster
echo "==> Deleting GKE Autopilot cluster (${CLUSTER_NAME})..."
gcloud container clusters delete ${CLUSTER_NAME} --region=${REGION} --quiet || true

# 2. Delete Cloud Run Service
echo "==> Deleting Cloud Run service (sample-app-run)..."
gcloud run services delete sample-app-run --region=${REGION} --quiet || true

# 3. Delete Artifact Registry Repository
echo "==> Deleting Artifact Registry repository (${REPO_NAME})..."
gcloud artifacts repositories delete ${REPO_NAME} --location=${REGION} --quiet || true

# 4. Delete Cloud Deploy Pipelines and Targets
echo "==> Deleting Cloud Deploy delivery pipelines and targets..."
gcloud deploy delivery-pipelines delete run-pipeline --region=${REGION} --force --quiet || true
gcloud deploy delivery-pipelines delete gke-pipeline --region=${REGION} --force --quiet || true
gcloud deploy targets delete run-target --region=${REGION} --quiet || true
gcloud deploy targets delete gke-target --region=${REGION} --quiet || true

echo "==> All workshop resources cleaned up successfully!"
