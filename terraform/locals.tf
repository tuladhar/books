locals {
  # Defaults applied to every droplet; override per-droplet below.
  droplet_defaults = {
    region = "sgp1"
    size   = "s-1vcpu-2gb-amd"
    image  = "ubuntu-24-04-x64"
  }

  # One entry per VM. Add a new VM by adding a new key:
  #   "docs" = { name = "docs.purutuladhar.com", size = "s-2vcpu-2gb" }
  droplets = {
    "books" = {
      name = "books.purutuladhar.com"
    }
  }

  # Merged view consumed by main.tf
  droplets_merged = {
    for key, droplet in local.droplets : key => merge(local.droplet_defaults, droplet)
  }
}
