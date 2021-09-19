output "docker-image" {
        description = "AWS ECR resources"
        value = module.docker-image
}

output "lambda" {
        description = "AWS lambda resources"
        value = module.lambda
}
