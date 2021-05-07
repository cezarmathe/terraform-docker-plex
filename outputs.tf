# terraform-docker-plex - outputs.tf

output "config_volume_name" {
  description = <<-DESCRIPTION
  Name of the config volume.
  If 'create_config_volume' is set to 'false' this output will hold an empty string.
  DESCRIPTION
  value       = var.create_config_volume ? docker_volume.config[0].name : ""
}

output "movies_volume_name" {
  description = <<-DESCRIPTION
  Name of the movies volume.
  If 'create_movies_volume' is set to 'false' this output will hold an empty string.
  DESCRIPTION
  value       = var.create_movies_volume ? docker_volume.movies[0].name : ""
}

output "tvseries_volume_name" {
  description = <<-DESCRIPTION
  Name of the tvseries volume.
  If 'create_tvseries_volume' is set to 'false' this output will hold an empty string.
  DESCRIPTION
  value       = var.create_tvseries_volume ? docker_volume.tvseries[0].name : ""
}

output "this_name" {
  description = "Name of the container."
  value       = docker_container.this.name
}

output "this_network_data" {
  description = <<-DESCRIPTION
  Network configuration of the container. This exports the 'network_data' attribute of the docker
  container, check the docker provider (kreuzwerker/docker) for more info.
  DESCRIPTION
  value       = docker_container.this.network_data
}

output "this_uuid" {
  description = "The random uuid used for naming the resources created by this module."
  value       = random_uuid.this.result
}
