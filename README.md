cat <<'EOF' > README.md
# Cloud-Native Development with GCP: Build, Deploy, and Automate

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/neelshah2409/cloud-native-gcp-workshop&cloudshell_tutorial=README.md)

This hands-on workshop walks through building, containerizing, and orchestrating deployments across Google Cloud using **Cloud Build**, **Artifact Registry**, **Cloud Run**, **GKE**, and **Cloud Deploy**.

---

## Quickstart

### 1. Launch Environment
Click the **Open in Cloud Shell** button above to clone this repository into a managed Cloud Shell environment.

### 2. Run Infrastructure Bootstrap
Run the setup script to enable APIs, create the Artifact Registry repository, provision the GKE cluster, and configure IAM bindings:

```bash
bash setup.sh
