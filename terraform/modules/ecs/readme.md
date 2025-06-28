# ECS Module

## Description
This module creates an ECS Cluster, Task Definition, Service, and security group to run the containerized Node.js app.

## Inputs
- `vpc_id`: VPC ID
- `subnet_ids`: Subnet IDs for the ECS tasks
- `alb_sg_id`: Security group ID of the ALB (for ingress)
- `target_group_arn`: ARN of the target group to attach ECS service to
- `execution_role_arn`: IAM role for ECS task execution
- `ecr_image_url`: URL of the ECR image to deploy
- `lb_listener_depends_on`: Dependency handle for ECS service
- `desired_count`: (Optional) number of tasks to run

## Outputs
None

