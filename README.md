# DevOps CI/CD: Docker and Kubernetes Deployment

A hands-on DevOps project demonstrating an automated CI/CD workflow using **Azure DevOps, Docker, and Kubernetes**.

The project containerizes a lightweight **Nginx web application**, validates Kubernetes manifests, and deploys the application to a **local Kubernetes cluster running through Docker Desktop**.

## Overview

The project demonstrates a complete development-to-deployment workflow:

```text
                    ┌─────────────────┐
                    │    Developer    │
                    └────────┬────────┘
                             │
                         git push
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Azure Pipelines   │
                  └──────────┬──────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
        Docker Build    K8s Validation    Deploy
              │              │              │
              └──────────────┼──────────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │    Docker Desktop   │
                  │  Kubernetes Cluster │
                  └──────────┬──────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │   Nginx Web App │
                    └─────────────────┘
```

## Technologies

| Technology                         | Purpose                                  |
| ---------------------------------- | ---------------------------------------- |
| **Azure DevOps Repos**             | Source control and repository management |
| **Azure Pipelines**                | CI/CD pipeline automation                |
| **Docker**                         | Application containerization             |
| **Nginx**                          | Lightweight web server                   |
| **Kubernetes**                     | Container orchestration and deployment   |
| **kubectl**                        | Kubernetes command-line interface        |
| **Docker Desktop**                 | Local Kubernetes environment             |
| **YAML**                           | Pipeline and Kubernetes configuration    |
| **Self-hosted Azure DevOps Agent** | Pipeline execution                       |

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

The Azure Pipelines workflow is triggered by changes pushed to the `main` branch.

The pipeline consists of three main stages:

### 1. Build

The pipeline builds the Docker image from the application source:

```bash
docker build -t demo-app:latest .
```

This creates a container image containing the Nginx web application and the project's `index.html` file.

### 2. Validate

Before deployment, the pipeline verifies the Kubernetes environment and configuration.

The validation process includes:

* Checking the Kubernetes client configuration
* Verifying the active Kubernetes context
* Checking cluster node availability
* Validating Kubernetes manifests
* Confirming that the required deployment environment is accessible

### 3. Deploy

After successful validation, the Kubernetes resources are deployed using:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

The pipeline then waits for the Deployment rollout and checks the resulting Kubernetes resources.

This provides an automated workflow from source code changes to application deployment.

## Kubernetes Configuration

The Kubernetes configuration is located in the `k8s/` directory.

### Deployment

The `deployment.yaml` file defines a Kubernetes Deployment for the Nginx-based application.

The Deployment:

* Runs one application replica
* Uses the locally built `demo-app:latest` Docker image
* Exposes container port `80`
* Uses `imagePullPolicy: Never` for the local Docker Desktop environment

### Service

The `service.yaml` file defines a Kubernetes `NodePort` Service.

The Service provides access to the Nginx application from outside the Kubernetes Pod through the local Docker Desktop Kubernetes environment.

## Running Locally with Docker

### 1. Build the Docker Image

From the project root directory, run:

```bash
docker build -t demo-app:latest .
```

### 2. Run the Container

Start the application directly with Docker:

```bash
docker run --rm -p 8080:80 demo-app:latest
```

The application can then be accessed at:

```text
http://localhost:8080
```

## Running with Kubernetes

Make sure Kubernetes is enabled in Docker Desktop and that `kubectl` is configured to use the Docker Desktop Kubernetes context.

### 1. Apply the Deployment

```bash
kubectl apply -f k8s/deployment.yaml
```

### 2. Apply the Service

```bash
kubectl apply -f k8s/service.yaml
```

### 3. Check the Pods

```bash
kubectl get pods
```

### 4. Check the Service

```bash
kubectl get service demo-service
```

### 5. Check the Deployment

```bash
kubectl get deployment
```

The application can then be accessed through the NodePort assigned to the Kubernetes Service.

## Azure DevOps Agent Configuration

The CI/CD pipeline is designed to run on a **self-hosted Windows Azure DevOps agent**.

The agent environment requires:

* Docker
* kubectl
* Access to the local Kubernetes cluster
* A configured Azure DevOps agent

The example pipeline uses the following kubeconfig path:

```text
C:\azagent\.kube\config
```

This path is environment-specific and should be changed if the Azure DevOps agent uses a different kubeconfig location.

The self-hosted agent allows the Azure DevOps pipeline to interact with the locally running Docker and Kubernetes environment.

## CI/CD Workflow

The overall workflow can be summarized as:

```text
Git Push
   │
   ▼
Azure DevOps Pipeline
   │
   ▼
Build Docker Image
   │
   ▼
Validate Kubernetes Environment
   │
   ▼
Validate Kubernetes Manifests
   │
   ▼
Deploy Kubernetes Resources
   │
   ▼
Wait for Deployment Rollout
   │
   ▼
Check Pods and Service
   │
   ▼
Nginx Web Application
```

## What This Project Demonstrates

This project demonstrates practical experience with:

* Git-based source control
* Azure DevOps Repos
* Azure Pipelines
* CI/CD pipeline automation
* Docker image creation
* Containerized web applications
* Nginx
* Kubernetes Deployments
* Kubernetes Services
* Kubernetes manifest validation
* Automated Kubernetes deployment
* `kubectl` command-line operations
* Self-hosted Azure DevOps agents
* Local Kubernetes development with Docker Desktop
* YAML-based infrastructure and pipeline configuration

## Learning Outcomes

Through this project, the following DevOps concepts were practiced:

* Building containerized applications with Docker
* Creating automated CI/CD workflows
* Integrating source control with Azure Pipelines
* Managing Kubernetes resources using YAML manifests
* Deploying applications to Kubernetes
* Working with Kubernetes Services and Deployments
* Configuring a self-hosted Azure DevOps agent
* Connecting CI/CD pipelines with a local Kubernetes environment
* Troubleshooting Docker, Kubernetes, and pipeline configuration issues

## Project Limitations

This repository is designed as a **learning and portfolio project** and uses a local Kubernetes environment provided by Docker Desktop.

The Kubernetes Deployment uses:

```yaml
imagePullPolicy: Never
```

because the Docker image is built locally and is expected to be available directly to the local Docker Desktop Kubernetes environment.

As a result, this implementation is intended for local development and demonstration rather than production deployment.

## Possible Future Improvements

The project can be extended toward a more production-oriented CI/CD architecture by adding:

* A container registry such as Azure Container Registry
* Versioned Docker image tags
* Automated image publishing
* Deployment to a cloud Kubernetes service
* Kubernetes Secrets and ConfigMaps
* Environment-specific configurations
* Separate development and production environments
* Pipeline variables and reusable templates
* Deployment health checks
* Rollback strategies
* Monitoring and logging

## Conclusion

This project demonstrates how **source control, CI/CD automation, containerization, and Kubernetes orchestration** can be combined into a single development workflow.

The implementation uses **Azure DevOps, Docker, Kubernetes, Nginx, and Docker Desktop** to automate the process from a Git push to a deployed web application.

The project provides practical experience with the fundamental tools and concepts used in modern DevOps workflows while maintaining a simple local environment suitable for learning and portfolio demonstration.
