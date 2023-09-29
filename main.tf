# ----------------------------------------------------------------------------------------
# --- Terraform Variable Definitions ---

# -- START Common variables --
# -- END Common variables --

# -- START Container specific variables --
# -- START Container specific variables --

# ----------------------------------------------------------------------------------------
# --- START Terraform Docker network resource definitions ---
resource "docker_network" "mealie_network" {
  name   = "mealie_network"
  driver = "bridge"
}
# --- END Terraform Docker network resource definitions ---

# --- START Terraform Docker image resource definitions ---
resource "docker_image" "mealie_api" {
  name         = "ghcr.io/mealie-recipes/mealie:${var.mealie_container_vers}"
  keep_locally = true
}

resource "docker_image" "swag" {
  name         = "ghcr.io/linuxserver/swag:${var.swag_container_vers}"
  keep_locally = true
}
# --- END Terraform Docker image resource definitions ---


resource "docker_container" "mealie_api" {
  name         = "mealie-api"
  image        = docker_image.mealie_api.image_id
  hostname     = "mealie-api"
  restart      = "unless-stopped"
  must_run     = true
  domainname   = "mealie-api"
  network_mode = "bridge"
  env = [
    "ALLOW_SIGNUP=true",
    "PUID=${var.uid}",
    "PGID=${var.gid}",
    "TZ=${var.timezone}",
    "MAX_WORKERS=1",
    "WEB_CONCURRENCY=1",
    "BASE_URL=http://${var.mealie_fqdn}",
  ]
  ports {
    internal   = 9000
    external = 9925
  }
  volumes {
    host_path      = var.mealie_config_dir
    container_path = "/app/data"
  }
  networks_advanced {
    name = docker_network.mealie_network.name
  }
  # depends_on = [docker_container.kitchenowl]
}

# resource "docker_container" "swag" {
#   name         = "mealie-swag"
#   image        = docker_image.swag.image_id
#   hostname     = "mealie-swag"
#   restart      = "unless-stopped"
#   must_run     = true
#   domainname   = "mealie-swag"
#   network_mode = "bridge"
#   capabilities {
#     add = [
#       "NET_ADMIN"
#       ]
#   }
#   env = [
#     "PUID=${var.uid}",
#     "PGID=${var.gid}",
#     "TZ=${var.timezone}",
#     "URL=${var.mealie_fqdn}",
#     "EMAIL=${var.mealie_contact_email}",
#     "VALIDATION=http",
#     "MAX_WORKERS=1",
#     "WEB_CONCURRENCY=1",
#     "STAGING=false"
#   ]
#   ports {
#     internal   = 80
#     external = 80
#   }
#   ports {
#     internal   = 443
#     external = 443
#   }
#   volumes {
#     host_path      = var.swag_config_dir
#     container_path = "/config"
#   }
#   networks_advanced {
#     name = docker_network.mealie_network.name
#   }
#   depends_on = [docker_container.mealie_api]
# }