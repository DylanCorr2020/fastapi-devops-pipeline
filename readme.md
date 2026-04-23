# 🚀 FastAPI CI/CD Deployment on AWS (Terraform + Docker + GitHub Actions)

---

## 🎥 Demo

video link here

## 📌 Overview

This project demonstrates a fully automated, cloud-native deployment pipeline for a FastAPI backend application.

It replaces a manual deployment process with a secure and repeatable CI/CD workflow using Infrastructure as Code, containerization, and remote command execution.

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

## 🐳 Docker

### Build Image

```bash
docker build -t dcorr25/fast-api-backend:latest .

docker run -d --name fast-api -p 8000:8000 dcorr25/fast-api-backend

```

## 🔐 Security

- No SSH access required
- Uses IAM roles for EC2 permissions
- Credentials stored securely using GitHub Secrets
- Deployment handled via AWS Systems Manager (SSM)

## 🌐 Accessing the Application

```
    http://<EC2_PUBLIC_IP>:8000
```

## 🧪 How to Deploy

```
     git push origin main
```
