provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vm" {
  for_each = local.droplets_merged

  name       = each.value.name
  region     = each.value.region
  size       = each.value.size
  image      = each.value.image
  monitoring = true
  ipv6       = false
}
