variable "docker_build" {
	description = "The absolute directory path to the Docker build context."
	type = string
}

variable "environment_variables" {
        default = {}
        type = any
}

variable "function_name" {
	description = "The name you want to give you AWS Lambda function."
	type = string
}

variable "function_timeout" {
	default = "3"
	description = "In seconds, how long your AWS Lambda function will run before it hard stops whatever it is doing."
	type = string
}

variable "function_version" {
	description = "The version you want to give you AWS Lambda function."
	type = string
}
