##################################################
# Vars
##################################################
variable "platform_name" {
  type    = string
  default = null
}

variable "image_base_name" {
  type    = string
  default = null
}

variable "image_base_version" {
  type    = string
  default = null
}

variable "image_tag_suffix" {
  type    = string
  default = null
}

variable "system_packages_manager" {
  type    = string
  default = null
}


##################################################
# Builder
##################################################
source "docker" "build" {
  image   = "${var.image_base_name}:${var.image_base_version}"
  pull    = true
  commit  = true
  changes = [
    "VOLUME /app/data",
    "VOLUME /app/conf",
    "VOLUME /app/logs",
    "ENV TZ=UTC",
    "ENV CUID=1000",
    "ENV CGID=1000",
    "CMD /bin/bash",
    "ENTRYPOINT /bin/bash"
  ]
}


##################################################
# Build
##################################################
build {
  sources = ["source.docker.build"]

  provisioner "shell" {
    scripts = [
      "${path.root}/prepare.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "${var.system_packages_manager} -y update",
      "${var.system_packages_manager} -y upgrade",
    ]
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/${var.image_base_name}/prepare.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "${var.system_packages_manager} -y install tree",
      "${var.system_packages_manager} -y install wget",
      "${var.system_packages_manager} -y install nano",
      "${var.system_packages_manager} -y install htop",
      "${var.system_packages_manager} -y install unzip",
      "${var.system_packages_manager} -y install ansible",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y clean all"
    ]
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /opt/app/{bin,conf,data,logs}",
      "ln -s /opt/app /app",
      "rm -rf /var/cache/*",
      "rm -rf /var/log/*"
    ]
  }

  post-processor "docker-tag" {
    repository = "simpleunionspace/base"
    tags       = [
      "${var.platform_name}-${var.image_base_name}-${var.image_base_version}-${var.image_tag_suffix}",
      "${var.platform_name}-${var.image_base_name}-${var.image_base_version}"
    ]
  }
}
