# --- Container Metadata Variables ---

variable "uid" {
  type    = string
  default = "1000"
}

variable "gid" {
  type    = string
  default = "1000"
}

variable "timezone" {
  type    = string
  default = "America/Chicago"
}

variable "mealie_container_vers" {
  type    = string
  default = "nightly"
}

variable "swag_container_vers" {
  type    = string
  default = "latest"
}

variable "mealie_config_dir" {
  type    = string
  default = "/c/Users/jjambrose1s/Documents/git-projects/recipe-manager/containers/mealie/data"
}

variable "swag_config_dir" {
  type    = string
  default = "/c/Users/jjambrose1s/Documents/git-projects/recipe-manager/containers/mealie/swag"
}

# --- Container ENV Variables ---

variable "mealie_fqdn" {
  type    = string
  default = "home.jjambrose.info"
}

variable "mealie_contact_email" {
  type    = string
  default = "galaxy2198@gmail.com"
}