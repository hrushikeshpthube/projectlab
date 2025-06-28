# 🚀 Node ECS App

A containerized **Hello World Node.js application** deployed on **AWS ECS** using **Terraform** and **Docker**. The infrastructure includes Amazon ECS, ECR, ALB, and IAM roles to fully automate the deployment of this lightweight app.

---


## 📁 Project Structure

.
├── node-ecs-app/ # Node.js source code
│ └── Dockerfile # Multi-stage Dockerfile
├── scripts/ # Linux scripts for disk usage monitoring
├── terraform/ # Terraform configurations
│ └── modules/
│ ├── alb/ # ALB setup
│ ├── ecs/ # ECS setup
│ ├── ecr/ # ECR repository setup
│ └── iam/ # IAM policies for ECS tasks
├── trivy_report.txt # Security scan report of Docker image
└── README.md # This file



---


## 🌍 Application Overview

A simple Node.js app that responds with:

Hello World from Dockerized Node.js!


---

# 🚀 High Level Architecture
![HLA_architecture](https://github.com/user-attachments/assets/a0c941c1-19e3-4483-ac28-b393af162dea)

---
## 🐳 Docker

### 🔧 Dockerfile

Located at: `node-ecs-app/Dockerfile`  
- Implements **multi-stage build** for minimal image size.
- Uses a **non-root user** for improved container security.
- Installs only **production dependencies**.

### 🧪 Build & Run Locally

From project root:

docker build -t node-ecs-app .
docker run -d -p 3000:3000 node-ecs-app
curl http://localhost:3000
# Output: Hello World from Dockerized Node.js!

🛡️ Trivy Security Scan
To check for vulnerabilities in the Docker image:
trivy image 521162754037.dkr.ecr.eu-north-1.amazonaws.com/myecr-repo:latest
See trivy_report.txt for sample output.

☁️ AWS Deployment Using Terraform
The infrastructure is defined in the terraform/ directory using modules.

Component	File Path	Description
AWS Region	terraform/main.tf	Sets the provider and region
![main_ec2_server](https://github.com/user-attachments/assets/5fb85dd1-b9c2-4b64-9def-e6d8d3331c43)


ECR	terraform/modules/ecr/main.tf	Creates an ECR repo for Docker images
![ecr_registry_image](https://github.com/user-attachments/assets/83d7609e-60f3-4fc3-9b91-ba0d066c2d03)


ALB	terraform/modules/alb/main.tf	Sets up Application Load Balancer and listener
![ALB_dns_name](https://github.com/user-attachments/assets/0d55b47f-7170-4643-b5d7-03b7c43f2397)

ECS	terraform/modules/ecs/main.tf	Defines ECS Cluster, Task, Service, and Security Groups
![ecs_service](https://github.com/user-attachments/assets/3c4b620d-1be0-4048-98b7-b8ff88c21c97)

IAM	terraform/modules/iam/main.tf	Provides IAM roles and policies for ECS Task Execution
![ecs_tasks](https://github.com/user-attachments/assets/ee0755da-8bc3-433a-86ab-765f5db3588c)






📦 Push Docker Image to ECR
Use AWS ECR commands to authenticate and push:
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <ecr-uri>
docker tag node-ecs-app <ecr-uri>
docker push <ecr-uri>
Replace <ecr-uri> with your actual ECR repository URI.


🧪 Monitoring & Scripts
Example Linux script available in scripts/ to monitor disk usage and set alerts.

🌐 Access the App
Once deployed via Terraform, access the app via the ALB DNS:

http://node-app-alb-418728559.eu-north-1.elb.amazonaws.com/
![HelloWorld_final_output](https://github.com/user-attachments/assets/4172515b-eee2-494b-9191-808ea5233d79)

🙋‍♂️ Maintainer
GitHub: @hrushikeshpthube

