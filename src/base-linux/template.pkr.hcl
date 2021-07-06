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
  image   = "${var.i_image_base_name}:${var.i_image_base_version}"
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
  sources = ["source.docker.build"]

  provisioner "shell" {
    inline = [
      "${var.i_system_packages_manager} -y update",
      "${var.i_system_packages_manager} -y upgrade",
    ]
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/prepare.sh"
    ]
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/${var.i_image_base_name}/prepare.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "${var.i_system_packages_manager} -y update",
      "${var.i_system_packages_manager} -y install tree",
      "${var.i_system_packages_manager} -y install wget",
      "${var.i_system_packages_manager} -y install nano",
      "${var.i_system_packages_manager} -y install ansible",
      "${var.i_system_packages_manager} -y autoremove",
      "${var.i_system_packages_manager} -y autoremove",
      "${var.i_system_packages_manager} -y autoremove",
      "${var.i_system_packages_manager} -y clean all"
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
    repository = "simpleunionspace/base"
    tags       = [
      "${var.i_platform_name}-${var.i_image_base_name}-${var.i_image_base_version}-${var.i_image_tag_suffix}",
      "${var.i_platform_name}-${var.i_image_base_name}-${var.i_image_base_version}"
    ]
  }
}
