# Cloud-Native Development with GCP: Build, Deploy, and Automate

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/neelshah2409/cloud-native-gcp-workshop&cloudshell_tutorial=README.md)

Hands-on workshop demonstrating containerization, automated CI/CD pipelines, and multi-runtime delivery using **Cloud Build**, **Artifact Registry**, **Cloud Run**, **GKE Autopilot**, and **Cloud Deploy**.

---

## Workshop Architecture

```text
Source Code (Go) 
  └─► Cloud Build (Multi-stage Dockerfile)
        └─► Artifact Registry (Container Image)
              ├─► Cloud Deploy (run-pipeline) ──► Cloud Run (Serverless)
              └─► Cloud Deploy (gke-pipeline) ──► GKE Autopilot (Kubernetes)
This hands-on workshop walks through building, containerizing, and orchestrating deployments across Google Cloud using **Cloud Build**, **Artifact Registry**, **Cloud Run**, **GKE**, and **Cloud Deploy**.
```

## Quickstart

### 1. Launch Environment
Click the **Open in Cloud Shell** button above to clone this repository into a managed Cloud Shell environment.

### 2. Run Infrastructure Bootstrap
Run the setup script to enable APIs, create the Artifact Registry repository, provision the GKE cluster, and configure IAM bindings:
```
bash setup.sh
```

### 3. Build & Trigger Continuous Delivery

Submit the build to Cloud Build to compile the container image, push it to Artifact Registry, and create Cloud Deploy releases for both Cloud Run and GKE:

```bash
gcloud builds submit --config=cloudbuild.yaml

```

*(Optional)* Pass a custom image tag using your Git commit hash:

```bash
gcloud builds submit --config=cloudbuild.yaml --substitutions=_TAG=$(git rev-parse --short HEAD)

```

### 4. Verify Deployments

#### Cloud Run (`run-pipeline`)

Inspect the rollout in **Cloud Deploy > Delivery Pipelines > `run-pipeline**`, then fetch and test the live HTTPS endpoint:

```bash
RUN_URL=$(gcloud run services describe sample-app-run --region=us-central1 --format='value(status.url)')
echo "Cloud Run URL: $RUN_URL"
curl -i "$RUN_URL"

```

#### GKE Autopilot (`gke-pipeline`)

Inspect the rollout in **Cloud Deploy > Delivery Pipelines > `gke-pipeline**`, then connect to the cluster and check the running pods and LoadBalancer service:

```bash
gcloud container clusters get-credentials workshop-cluster --region=us-central1
kubectl get pods
kubectl get svc sample-app-service

```

Once `EXTERNAL-IP` is assigned, verify the endpoint:

```bash
curl -i http://<EXTERNAL-IP>

```

### 5. Cleanup & Teardown

Delete the GKE cluster, Cloud Run service, Artifact Registry repository, and Cloud Deploy pipelines to avoid ongoing charges:

```bash
bash cleanup.sh
```

If you liked the workshop then star the repo and follow me on [Linkedin](https://www.linkedin.com/in/neelcshah/) :)


