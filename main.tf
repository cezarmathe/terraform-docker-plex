# terraform-docker-plex - main.tf

resource "random_uuid" "this" {}

data "docker_registry_image" "this" {
  name = "%{ if var.use_ghcr }ghcr.io/%{ endif }linuxserver/plex:${var.image_version}"
}

resource "docker_image" "this" {
  name          = data.docker_registry_image.this.name
  pull_triggers = [data.docker_registry_image.this.sha256_digest]
}

resource "docker_volume" "config" {
  count = var.create_config_volume ? 1 : 0

  name        = local.config_volume_name
  driver      = var.config_volume_driver
  driver_opts = var.config_volume_driver_opts

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      label = label.key
      value = label.value
    }
  }
}

resource "docker_volume" "movies" {
  count = var.create_movies_volume ? 1 : 0

  name        = local.movies_volume_name
  driver      = var.movies_volume_driver
  driver_opts = var.movies_volume_driver_opts

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      label = label.key
      value = label.value
    }
  }
}

resource "docker_volume" "tvseries" {
  count = var.create_tvseries_volume ? 1 : 0

  name        = local.tvseries_volume_name
  driver      = var.tvseries_volume_driver
  driver_opts = var.tvseries_volume_driver_opts

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      label = label.key
      value = label.value
    }
  }
}

resource "docker_container" "this" {
  name  = local.container_name
  image = docker_image.this.latest

  env = [
    "PUID=${var.uid}",
    "PGID=${var.gid}",
    "VERSION=docker",
    "UMASK_SET=022",
    "PLEX_CLAIM=${var.plex_claim}"
  ]

  ports {
    internal = 32400
    external = 32400
    protocol = "tcp"
  }

  ports {
    internal = 1900
    external = 1900
    protocol = "udp"
  }

  ports {
    internal = 3005
    external = 3005
    protocol = "tcp"
  }

  ports {
    internal = 5353
    external = 5353
    protocol = "udp"
  }

  ports {
    internal = 8324
    external = 8324
    protocol = "tcp"
  }

  ports {
    internal = 32410
    external = 32410
    protocol = "udp"
  }

  ports {
    internal = 32412
    external = 32412
    protocol = "udp"
  }

  ports {
    internal = 32413
    external = 32413
    protocol = "udp"
  }

  ports {
    internal = 32414
    external = 32414
    protocol = "udp"
  }

  ports {
    internal = 32469
    external = 32469
    protocol = "tcp"
  }

  # config volume
  dynamic "volumes" {
    for_each = docker_volume.config
    iterator = volume
    content {
      volume_name    = volume.value.name
      container_path = "/config"
    }
  }

  # movies volume
  dynamic "volumes" {
    for_each = docker_volume.movies
    iterator = volume
    content {
      volume_name    = volume.value.name
      container_path = "/movies"
    }
  }

  # tvseries volume
  dynamic "volumes" {
    for_each = docker_volume.tvseries
    iterator = volume
    content {
      volume_name    = volume.value.name
      container_path = "/tvseries"
    }
  }

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      label = label.key
      value = label.value
    }
  }

  must_run = true
  restart  = var.restart
  start    = var.start
}

locals {
  config_volume_name = var.create_config_volume ? (
    var.config_volume_name != "" ? var.config_volume_name : (
      "plex_config_${random_uuid.this.result}"
    )
  ) : ""

  movies_volume_name = var.create_movies_volume ? (
    var.movies_volume_name != "" ? var.movies_volume_name : (
      "plex_movies_${random_uuid.this.result}"
    )
  ) : ""

  tvseries_volume_name = var.create_tvseries_volume ? (
    var.tvseries_volume_name != "" ? var.tvseries_volume_name : (
      "plex_tvseries_${random_uuid.this.result}"
    )
  ) : ""

  container_name = var.container_name != "" ? var.container_name : (
    "plex_${random_uuid.this.result}"
  )
}
