module "docker-image" {
	source = "terraform-aws-modules/lambda/aws//modules/docker-build"

	create_ecr_repo = true
	ecr_repo = var.function_name
	image_tag = var.function_version
	source_path = var.docker_build
}

module "lambda" {
	source = "terraform-aws-modules/lambda/aws"
	version = "~> 2.17"

	create_package = false
	environment_variables = var.environment_variables
	function_name = var.function_name
	image_uri = module.docker-image.image_uri
	package_type = "Image"
	timeout = var.function_timeout
}
