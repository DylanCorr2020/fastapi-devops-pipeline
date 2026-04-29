# 🚀 FastAPI CI/CD Deployment on AWS (Terraform + Docker + GitHub Actions)

---

## 🎥 Demo

video link here

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

<img width="100%" height="536" alt="Image" src="https://github.com/user-attachments/assets/e6136fc9-dd54-4640-8479-c3894877b06c" />

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

### 1. Clone the Repository

```bash
git clone git@github.com:DylanCorr2020/fastapi-devops-pipeline.git
cd  fast-api-devops-pipeline

```

### 2. Provision Infrastructure

```bash
cd terraform
terraform init
terrafrom apply

```

### 3. Configure GitHub Secrets

Add the following secrets in your repository:

- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN
- ACCESS_KEY_ID
- SECRET_ACCESS_KEY
- EC2_INSTANCE_ID

### 4. Trigger Deployment

```bash

   git push origin main

```

### 5. Accessing the Application

```
    http://<EC2_PUBLIC_IP>:8000
```

## Author

Dylan Corr
