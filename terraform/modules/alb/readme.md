# ALB Module

## Description
This module creates an Application Load Balancer (ALB), security group, listener, and target group.

## Inputs
- `vpc_id`: The VPC where ALB will be created
- `subnet_ids`: List of subnets for ALB

## Outputs
- `alb_sg_id`: Security group ID for the ALB
- `target_group_arn`: ARN of the target group
- `listener_depends_on`: ID to use for ECS service dependency
- `alb_dns_name`: Public DNS name of the ALB

