resource "aws_ecr_repository" "app" {
  name = "node-ecs-app"
}

output "repository_url" {
  value = aws_ecr_repository.app.repository_url
}
