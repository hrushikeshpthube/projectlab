variable "vpc_id" {}
variable "subnet_ids" {}
variable "alb_sg_id" {}
variable "target_group_arn" {}
variable "execution_role_arn" {}
variable "ecr_image_url" {}
variable "lb_listener_depends_on" {}

resource "aws_security_group" "ecs" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "main" {
  name = "node-app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "node-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name      = "node-container"
    image     = var.ecr_image_url
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "app" {
  name            = "node-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "node-container"
    container_port   = 3000
  }

  depends_on = [var.lb_listener_depends_on]
}
