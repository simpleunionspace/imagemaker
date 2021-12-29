##################################################
# Vars
##################################################
variable "im_platform_name" {
  type    = string
  default = null
}

variable "im_source_docker_repository_name" {
  type    = string
  default = ""
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
  default = "simpleunionspace/base"
}

variable "im_target_docker_image_tag_suffix" {
  type    = string
  default = null
}


##################################################
# Builder
##################################################
source "docker" "build" {
  image   = "${var.im_source_docker_repository_name}${var.im_source_image_base_name}:${var.im_source_image_base_version}"
  pull    = true
  commit  = true
  changes = [
    "VOLUME /opt/app/data",
    "VOLUME /opt/app/conf",
    "VOLUME /opt/app/logs",
    "VOLUME /opt/app/tmp",
    "ENV TZ=UTC",
    "ENV GID=1000",
    "ENV UID=1000",
    "CMD /bin/bash",
    "ENTRYPOINT /opt/entrypoint.sh"
  ]
}


##################################################
# Build
##################################################
build {
  sources = ["source.${var.im_target_name}.build"]

  provisioner "shell" {
    inline = [
      "${var.im_system_packages_manager} -y update",
      "${var.im_system_packages_manager} -y upgrade",
    ]
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/prepare.sh"
    ]
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/${var.im_source_image_base_name}/prepare.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "${var.im_system_packages_manager} -y update",
      "${var.im_system_packages_manager} -y install tree",
      "${var.im_system_packages_manager} -y install wget",
      "${var.im_system_packages_manager} -y install nano",
      "${var.im_system_packages_manager} -y install ansible",
      "${var.im_system_packages_manager} -y autoremove",
      "${var.im_system_packages_manager} -y autoremove",
      "${var.im_system_packages_manager} -y autoremove",
      "${var.im_system_packages_manager} -y clean all"
    ]
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /opt/app",
      "mkdir -p /opt/app/bin",
      "mkdir -p /opt/app/conf",
      "mkdir -p /opt/app/data",
      "mkdir -p /opt/app/logs",
      "mkdir -p /opt/app/tmp",
      "ln -s /opt/app /app",
      "rm -rf /var/cache/*",
      "rm -rf /var/log/*"
    ]
  }

  provisioner "file" {
    sources = [
      "${path.root}/entrypoint.sh",
    ]
    destination = "/opt/"
  }

  post-processor "docker-tag" {
    repository = "${var.im_target_docker_repository_name}"
    tags       = [
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}-${var.im_target_docker_image_tag_suffix}",
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}"
    ]
  }
}
