# DevOps CI/CD: Docker and Kubernetes Deployment

A hands-on DevOps project demonstrating an automated CI/CD workflow using **Azure DevOps, Docker, and Kubernetes**.

The project containerizes a lightweight **Nginx web application**, validates Kubernetes manifests, and automatically deploys the application to a **local Kubernetes cluster running on Docker Desktop**.

## Architecture

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
