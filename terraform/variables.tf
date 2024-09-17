variable "docker_registry_username" {
  description = "The username for the Docker registry"
}

variable "docker_registry_password" {
  description = "The password for the Docker registry"
  sensitive   = true
}
