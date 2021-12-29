##################################################
# Vars
##################################################
variable "im_platform_name" {
  type    = string
  default = null
}

variable "im_source_docker_repository_name" {
  type    = string
  default = "mcr.microsoft.com/windows/"
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
    "VOLUME C:\app\data",
    "VOLUME C:\app\conf",
    "VOLUME C:\app\logs",
    "VOLUME C:\app\tmp",
    "ENV TZ=UTC",
    "ENV GID=1000",
    "ENV UID=1000",
    "CMD powershell",
    "ENTRYPOINT C:\entrypoint.ps1"
  ]
}


##################################################
# Build
##################################################
build {
  sources = ["source.${var.im_target_name}.build"]

  provisioner "powershell" {
    inline = [
      # TODO: need update system
    ]
  }

  provisioner "powershell" {
    scripts = [
      "${path.root}/prepare.ps1"
    ]
  }

  provisioner "powershell" {
    scripts = [
      "${path.root}/${var.im_source_image_base_name}/prepare.ps1"
    ]
  }

  provisioner "powershell" {
    inline = [
      # TODO: need install system tools
    ]
  }

  provisioner "powershell" {
    inline = [
      New-Item -Path "c:\"    -Name "app"  -ItemType "directory",
      New-Item -Path "c:\app" -Name "bin"  -ItemType "directory",
      New-Item -Path "c:\app" -Name "conf" -ItemType "directory",
      New-Item -Path "c:\app" -Name "data" -ItemType "directory",
      New-Item -Path "c:\app" -Name "logs" -ItemType "directory",
      New-Item -Path "c:\app" -Name "tmp"  -ItemType "directory",
    ]
  }

  provisioner "file" {
    sources = [
      "${path.root}/entrypoint.ps1",
    ]
    destination = "C:\"
  }

  post-processor "docker-tag" {
    repository = "${var.im_target_docker_repository_name}"
    tags       = [
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}-${var.im_target_docker_image_tag_suffix}",
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}"
    ]
  }
}
