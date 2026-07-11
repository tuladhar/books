provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vm" {
  name       = var.droplet_name
  region     = var.droplet_region
  size       = var.droplet_size
  image      = var.droplet_image
  tags       = var.droplet_tags
  monitoring = true
  ipv6       = true
}
