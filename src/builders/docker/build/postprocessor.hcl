  post-processor "docker-tag" {
    repository = "${var.im_target_docker_repository_name}"
    tags       = [
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}-${var.im_target_docker_image_tag_suffix}",
      "${var.im_platform_name}-${var.im_source_image_base_name}-${var.im_source_image_base_version}"
    ]
  }