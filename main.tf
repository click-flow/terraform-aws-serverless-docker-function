module "config" {
	source  = "click-flow/file-content-to-object/local"
	version = "0.0.2"

	filename = length(var.config_file) > 0 ? var.config_file : "${path.module}/config.bash"
}

module "docker-image" {
	source = "terraform-aws-modules/lambda/aws//modules/docker-build"

	create_ecr_repo = true
	ecr_repo = module.config.variables.FUNCTION_NAME
	image_tag = module.config.variables.VERSION
	source_path = abspath(path.module)
}

module "lambda" {
	source = "terraform-aws-modules/lambda/aws"
	version = "~> 2.17"

	create_package = false
	environment_variables = var.environment_variables
	function_name = module.config.variables.FUNCTION_NAME
	image_uri = module.docker-image.image_uri
	package_type = "Image"
	timeout = module.config.variables.TIMEOUT
}
