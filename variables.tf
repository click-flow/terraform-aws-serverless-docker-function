variable "config_file" {
        default = "${path.module}/config.bash"
        type = string
}

variable "environment_variables" {
        default = {}
        type = any
}
