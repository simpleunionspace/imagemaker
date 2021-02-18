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
  image   = "simpleunionspace/base:${var.platform_name}-${var.image_base_name}-${var.image_base_version}"
  pull    = true
  commit  = true
  changes = [
    "CMD /bin/bash",
    "ENTRYPOINT /bin/bash"
  ]
}


build {
  sources = ["source.docker.build"]

  provisioner "ansible-local" {
    playbook_file   = "${path.root}/playbook.yaml"
    extra_arguments = [
      "--extra-vars",
      "\"platform_name=${var.platform_name}\""
    ]
  }

  post-processor "docker-tag" {
    repository = "simpleunionspace/test"
    tags       = [
      "${var.platform_name}-${var.image_base_name}-${var.image_base_version}-${var.image_tag_suffix}",
      "${var.platform_name}-${var.image_base_name}-${var.image_base_version}"
    ]
  }
}
