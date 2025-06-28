provider "aws" {
  region = "eu-north-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"
}

module "alb" {
  source = "./modules/alb"
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id            = data.aws_vpc.default.id
  subnet_ids        = data.aws_subnets.default.ids
  alb_sg_id         = module.alb.alb_sg_id
  target_group_arn  = module.alb.target_group_arn
  lb_listener_depends_on = module.alb.listener_depends_on
  execution_role_arn = module.iam.execution_role_arn
  ecr_image_url      = "521162754037.dkr.ecr.eu-north-1.amazonaws.com/myecr-repo:latest"
}
