# terraform-docker-plex - main.tf

variable "uid" {
  type        = number
  description = "Uid for the plex process."
  default     = 1000
}

variable "gid" {
  type        = number
  description = "Gid for the plex process."
  default     = 1000
}

variable "image_version" {
  type        = string
  description = <<-DESCRIPTION
  Container image version. This module uses 'linuxserver/plex'.
  DESCRIPTION
  default     = "latest"
}

variable "start" {
  type        = bool
  description = "Whether to start the container or just create it."
  default     = true
}

variable "restart" {
  type        = string
  description = <<-DESCRIPTION
  The restart policy of the container. Must be one of: "no", "on-failure", "always",
  "unless-stopped".
  DESCRIPTION
  default     = "unless-stopped"
}

variable "create_config_volume" {
  type        = bool
  description = "Create a volume for the '/config' directory."
  default     = true
}

variable "config_volume_name" {
  type        = string
  description = <<-DESCRIPTION
  The name of the config volume. If empty, a name will be automatically generated like this:
  'plex_config_{random-uuid}'.
  DESCRIPTION
  default     = ""
}

variable "config_volume_driver" {
  type        = string
  description = "Storage driver for the config volume."
  default     = "local"
}

variable "config_volume_driver_opts" {
  type        = map(any)
  description = "Storage driver options for the config volume."
  default     = {}
}

variable "create_movies_volume" {
  type        = bool
  description = "Create a volume for the '/movies' directory."
  default     = true
}

variable "movies_volume_name" {
  type        = string
  description = <<-DESCRIPTION
  The name of the movies volume. If empty, a name will be automatically generated like this:
  'plex_movies_{random-uuid}'.
  DESCRIPTION
  default     = ""
}

variable "movies_volume_driver" {
  type        = string
  description = "Storage driver for the movies volume."
  default     = "local"
}

variable "movies_volume_driver_opts" {
  type        = map(any)
  description = "Storage driver options for the movies volume."
  default     = {}
}

variable "create_tvseries_volume" {
  type        = bool
  description = "Create a volume for the '/tvseries' directory."
  default     = true
}

variable "tvseries_volume_name" {
  type        = string
  description = <<-DESCRIPTION
  The name of the tvseries volume. If empty, a name will be automatically generated like this:
  'plex_tvseries_{random-uuid}'.
  DESCRIPTION
  default     = ""
}

variable "tvseries_volume_driver" {
  type        = string
  description = "Storage driver for the tvseries volume."
  default     = "local"
}

variable "tvseries_volume_driver_opts" {
  type        = map(any)
  description = "Storage driver options for the tvseries volume."
  default     = {}
}

variable "container_name" {
  type        = string
  description = <<-DESCRIPTION
  The name of the plex container. If empty, one will be generated like this:
  'plex_{random-uuid}'.
  DESCRIPTION
  default     = ""
}

variable "use_ghcr" {
  type        = bool
  description = <<-DESCRIPTION
  Whether to use GitHub container registry for getting the container image instead of Docker Hub.
  DESCRIPTION
  default     = false
}

variable "labels" {
  type        = map(string)
  description = "Labels to attach to created resources that support labels."
  default     = {}
}

variable "plex_claim" {
  type        = string
  description = <<-DESCRIPTION
  Plex claim to use to connect your server to your account. Get it from https://www.plex.tv/claim/.
  DESCRIPTION
}
