# DevOps CI/CD: Docker and Kubernetes Deployment

A hands-on DevOps project demonstrating an automated CI/CD workflow with **Azure DevOps, Docker, and Kubernetes**. The application is a lightweight Nginx web page that is containerized, validated, and deployed to a local Kubernetes cluster running through Docker Desktop.

## Overview

The project demonstrates the following workflow:

```text
Developer pushes to main
          |
          v
   Azure DevOps Pipeline
          |
          +--> Build Docker image
          |
          +--> Validate Kubernetes manifests
          |
          +--> Deploy to Kubernetes
          |
          v
    Docker Desktop
    Kubernetes Cluster
          |
          v
      Nginx Web App
```

## Technologies

- **Azure DevOps Repos** – source control
- **Azure Pipelines** – CI/CD automation
- **Docker** – containerization
- **Nginx** – lightweight web server
- **Kubernetes** – container orchestration
- **kubectl** – Kubernetes command-line interface
- **Docker Desktop** – local Kubernetes environment
- **YAML** – pipeline and Kubernetes configuration
- **Self-hosted Azure DevOps agent** – pipeline execution

## Project Structure

```text
.
├── index.html
├── Dockerfile
├── azure-pipelines.yml
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── .gitignore
└── README.md
```

## CI/CD Pipeline

The Azure Pipelines workflow is triggered by pushes to the `main` branch.

### 1. Build

The pipeline builds the application image:

```bash
docker build -t demo-app:latest .
```

### 2. Validate

The pipeline checks the Kubernetes client, cluster context, and node availability. It also performs a client-side validation of the Kubernetes manifests.

### 3. Deploy

The Kubernetes resources are applied with:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

The pipeline then waits for the Deployment rollout and checks the resulting Pods and Service.

## Kubernetes Configuration

### Deployment

The Deployment creates one replica of the Nginx-based application and exposes container port `80`.

### Service

A Kubernetes `NodePort` Service exposes the application outside the cluster.

## Running Locally

### Build the Docker image

```bash
docker build -t demo-app:latest .
```

### Run the container directly

```bash
docker run --rm -p 8080:80 demo-app:latest
```

Then open `http://localhost:8080`.

### Deploy to Kubernetes

Make sure Kubernetes is enabled in Docker Desktop and that `kubectl` is configured for the Docker Desktop context.

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods
kubectl get service demo-service
```

## Azure DevOps Agent Configuration

The pipeline is designed for a **self-hosted Windows agent** with Docker, `kubectl`, and access to the local Kubernetes cluster.

The example pipeline uses the following kubeconfig path on the agent:

```text
C:\azagent\.kube\config
```

This path is environment-specific and should be changed if the agent uses a different configuration path.

## What This Project Demonstrates

- Source control with Git
- CI/CD pipeline automation
- Docker image creation
- Kubernetes Deployments and Services
- Kubernetes manifest validation
- Automated application deployment
- Self-hosted build agent configuration
- Local Kubernetes development with Docker Desktop

## Notes

This repository is intended as a learning and portfolio project. The Kubernetes deployment uses a locally available Docker image (`imagePullPolicy: Never`) and is therefore designed for a local Docker Desktop Kubernetes environment rather than a production container registry workflow.
