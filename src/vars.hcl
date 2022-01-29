variable "im_platform_name" {
  type    = string
  default = null
}

variable "im_source_docker_repository_prefix" {
  type    = string
  default = "simpleunionspace/"
}

variable "im_source_docker_repository_name" {
  type    = string
  default = "${var.im_source_docker_repository_prefix}"
}

variable "im_source_image_base_name" {
  type    = string
  default = null
}

variable "im_source_image_base_version" {
  type    = string
  default = null
}

variable "im_system_packages_manager" {
  type    = string
  default = null
}

variable "im_target_prefix" {
  type    = string
  default = null
}

variable "im_target_suffix" {
  type    = string
  default = null
}

variable "im_target_docker_repository_prefix" {
  type    = string
  default = "simpleunionspace/"
}

variable "im_target_docker_repository_name" {
  type    = string
  default = "${var.im_target_docker_repository_prefix}"
}
