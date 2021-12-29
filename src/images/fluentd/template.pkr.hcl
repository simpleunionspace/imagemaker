##################################################
# Vars
##################################################
variable "im_platform_name" {
  type    = string
  default = null
}

variable "im_source_docker_repository_name" {
  type    = string
  default = "simpleunionspace/base"
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

variable "im_target_name" {
  type    = string
  default = "docker"
}

variable "im_target_docker_repository_name" {
  type    = string
  default = "simpleunionspace/fluentd"
}

variable "im_target_docker_image_tag_suffix" {
  type    = string
  default = null
}


##################################################
# Builder
##################################################
source "docker" "build" {
  image   = "${var.im_source_docker_repository_name}:${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}"
  pull    = true
  commit  = true
  changes = [
    "CMD /bin/bash",
    "ENTRYPOINT /bin/bash",
  ]
}


##################################################
# Build
##################################################
build {
  sources = ["source.${var.im_target_name}.build"]

  provisioner "shell" {
    inline = [
      "mkdir /opt/bootstrap",
    ]
  }

  provisioner "file" {
    sources = [
      "${path.root}/playbook.yaml",
      "${path.root}/../deps_install.yaml",
      "${path.root}/../deps_uninstall.yaml",
      "${path.root}/../facts.yaml",
      "${path.root}/../vars.yaml",
    ]
    destination = "/opt/bootstrap/"
  }

  provisioner "shell" {
    inline = [
      "ansible-playbook -c local --extra-vars \"im_platform_name=${var.im_platform_name}\" /opt/bootstrap/playbook.yaml",
      "rm -rf /opt/bootstrap",
    ]
  }

  post-processor "docker-tag" {
    repository = "${var.im_target_docker_repository_name}"
    tags       = [
      "${var.im_fluentd_version}-${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}-${var.im_target_docker_image_tag_suffix}",
      "${var.im_fluentd_version}-${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}",
    ]
  }
}
