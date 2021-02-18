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


source "docker" "build" {
  image   = "mcr.microsoft.com/windows/${var.image_base_name}:${var.image_base_version}"
  pull    = true
  commit  = true
  changes = [
    "VOLUME /app/data",
    "VOLUME /app/conf",
    "VOLUME /app/logs",
    "VOLUME /app/tmp",
    "ENV TZ=UTC",
    "ENV CUID=1000",
    "ENV CGID=1000",
    "CMD /bin/bash",
    "ENTRYPOINT /bin/bash"
  ]
}


build {
  sources = ["source.docker.build"]

  provisioner "shell" {
    inline = [
      "rm -rf /etc/localtime",
      "ln -s /usr/share/zoneinfo/GMT /etc/localtime",
      "${var.system_packages_manager} -y update",
      "${var.system_packages_manager} -y upgrade",
      "${var.system_packages_manager} -y install less",
      "${var.system_packages_manager} -y install tree",
      "${var.system_packages_manager} -y install nano",
      "${var.system_packages_manager} -y install wget",
      "${var.system_packages_manager} -y install gettext",
      "${var.system_packages_manager} -y install telnet",
      "${var.system_packages_manager} -y install tcpdump",
      "${var.system_packages_manager} -y install strace",
      "${var.system_packages_manager} -y install htop",
      "${var.system_packages_manager} -y install unzip",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y autoremove",
      "${var.system_packages_manager} -y clean all",
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
