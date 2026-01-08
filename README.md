# Azure DevOps CI/CD ile Kubernetes Deployment

Bu proje, Azure DevOps kullanılarak modern bir CI/CD hattının
uçtan uca kurulmasını ve Docker Desktop üzerindeki Kubernetes
ortamına otomatik deployment yapılmasını göstermektedir.

## Proje Akışı

1. Kodlar Azure DevOps Repo üzerinde tutulmaktadır.
2. Main branch'e yapılan her push işlemi pipeline'ı otomatik tetikler.
3. Pipeline, self-hosted Linux agent (Docker container) üzerinde çalışır.
4. Docker image build edilir.
5. Kubernetes deployment.yaml ve service.yaml dosyaları kullanılarak
   uygulama Kubernetes ortamına deploy edilir.

## Kullanılan Teknolojiler

- Azure DevOps Repos & Pipelines
- Docker Desktop
- Kubernetes (local)
- kubectl
- Self-hosted Linux Agent
- PowerShell (Windows ortamı)

## Pipeline Özellikleri

- Otomatik tetiklenme (push ile)
- Default agent pool kullanımı
- Docker image build işlemi
- Kubernetes'e otomatik deployment
- Manuel işlem içermez

## Doğrulama

Pipeline başarıyla çalıştıktan sonra aşağıdaki komut ile
Kubernetes üzerindeki pod'lar kontrol edilmiştir:

```bash
kubectl get pods
