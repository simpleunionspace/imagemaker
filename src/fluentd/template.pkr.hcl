##################################################
# Vars
##################################################
variable "i_platform_name" {
  type    = string
  default = null
}

variable "i_image_base_name" {
  type    = string
  default = null
}

variable "i_image_base_version" {
  type    = string
  default = null
}

variable "i_image_tag_suffix" {
  type    = string
  default = null
}

variable "i_system_packages_manager" {
  type    = string
  default = null
}


##################################################
# Builder
##################################################
source "docker" "build" {
  image   = "simpleunionspace/base:${var.i_platform_name}-${var.i_image_base_name}-${var.i_image_base_version}"
  pull    = false
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
  sources = ["source.docker.build"]

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
      "ansible-playbook -c local --extra-vars \"i_platform_name=${var.i_platform_name}\" /opt/bootstrap/playbook.yaml",
      "rm -rf /opt/bootstrap",
    ]
  }

  post-processor "docker-tag" {
    repository = "simpleunionspace/fluentd"
    tags       = [
      "${var.i_platform_name}-${var.i_image_base_name}-${var.i_image_base_version}-${var.i_image_tag_suffix}",
      "${var.i_platform_name}-${var.i_image_base_name}-${var.i_image_base_version}",
    ]
  }
}
