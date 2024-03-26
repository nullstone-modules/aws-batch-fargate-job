variable "cpu" {
  type    = number
  default = 0.25
}

variable "memory" {
  type    = number
  default = 256
}

variable "image" {
  type        = string
  default     = ""
  description = <<EOF
The docker image to deploy for this service.
By default, this is blank, which means that an ECR repo is created and used.
Use this variable to configure against docker hub, quay, etc.
EOF
}

variable "command" {
  type        = list(string)
  default     = []
  description = <<EOF
This overrides the `CMD` specified in the image.
Specify a blank list to use the image's `CMD`.
Each token in the command is an item in the list.
For example, `echo "Hello World"` would be represented as ["echo", "\"Hello World\""].
EOF
}
