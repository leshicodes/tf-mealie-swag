terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}


# WINDOWS
# provider "docker" {
#   host = "npipe:////.//pipe//docker_engine"
# }

# UNIX / Linux
provider "docker" {
  host = "unix:///var/run/docker.sock"
}