module "docker-image" {
	source = "terraform-aws-modules/lambda/aws//modules/docker-build"
	version = "2.30.0"

	create_ecr_repo = true
	ecr_repo = var.function_name
	ecr_repo_lifecycle_policy = jsonencode({
		rules = [
			{
				action = { type = "expire" }
				description = "Keep only the last 2 images"
				rulePriority = 1
				selection = {
					countNumber = 2
					countType = "imageCountMoreThan"
					tagStatus = "any"
				}
			}
		]
	})
	image_tag = var.function_version
	source_path = var.docker_build
}

module "lambda" {
	source = "terraform-aws-modules/lambda/aws"
	version = "2.30.0"

	create_package = false
	environment_variables = var.environment_variables
	function_name = var.function_name
	image_uri = module.docker-image.image_uri
	memory_size = var.function_memory_size
	package_type = "Image"
	timeout = var.function_timeout
}
