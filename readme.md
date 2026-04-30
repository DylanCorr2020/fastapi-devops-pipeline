# 🚀 FastAPI CI/CD Deployment on AWS (Terraform + Docker + GitHub Actions)

---

## 🎥 Demo

[![Watch Demo](https://cdn.loom.com/sessions/thumbnails/fd7d4a86a0904ed6a445dc930ad08170-with-play.gif)](https://www.loom.com/share/fd7d4a86a0904ed6a445dc930ad08170)

---

## 📌 Overview

Automated CI/CD pipeline for deploying a FastAPI app to AWS EC2 using Terraform, Docker, GitHub Actions, and AWS SSM.

---

## ❗ Problem

- Manual and repetitive process
- Risk of human error
- Requires SSH access (security concern)
- No consistency between deployments
- Slow development feedback loop

---

## 💡 Solution

- Fully automated deployments
- No SSH access required
- Consistent and reproducible infrastructure
- Faster development workflow
- Improved security using IAM roles

---

## 🏗️ Architecture

<img width="1774" height="887" alt="Image" src="https://github.com/user-attachments/assets/32e14f2d-03a9-4f33-b5ea-7cbcb5a93453" />

### Flow Explanation:

1. Developer pushes code to GitHub
2. GitHub Actions builds a Docker image
3. Image is pushed to Docker Hub
4. GitHub Actions triggers AWS SSM
5. EC2 pulls the latest image
6. Existing container is replaced with the new version

---

## 🧰 Tech Stack

- Backend: FastAPI (Python)
- Infrastructure: Terraform
- Cloud: AWS EC2
- Containerization: Docker
- CI/CD: GitHub Actions
- Remote Execution: AWS Systems Manager (SSM)

---

## ⚙️ Infrastructure Setup

The infrastructure is provisioned using Terraform.

### EC2 Configuration:

- Ubuntu-based instance
- Docker installed via `user_data` script
- IAM role attached with SSM permissions

### Key Features:

- Fully automated server setup
- No manual configuration required
- Ready for CI/CD integration on launch

---

## 🚀 How to Deploy

### 📦 Prerequisites

- Git
- Docker
- Terraform
- AWS CLI (configured with credentials)
- GitHub account
- Docker Hub account

---

### 📥 Clone the Repository

```bash
git clone git@github.com:DylanCorr2020/fastapi-devops-pipeline.git
cd  fast-api-devops-pipeline

```

### 🏗️ Provision Infrastructure

```bash
cd terraform
terraform init
terraform apply

```

### 🔐 Configure GitHub Secrets

Add the following secrets in your repository:

- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN
- ACCESS_KEY_ID
- SECRET_ACCESS_KEY
- EC2_INSTANCE_ID

### 🚀 Trigger Deployment

```bash

   git push origin main

```

### 🌐 Accessing the Application

```
    http://<EC2_PUBLIC_IP>:8000
```

## 👤 Author

Dylan Corr
