# API token from var.cloudflare_api_token or CLOUDFLARE_API_TOKEN env var
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# One A record per droplet, pointing the droplet's name at its public IPv4
resource "cloudflare_dns_record" "vm" {
  for_each = local.droplets_merged

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  type    = "A"
  content = digitalocean_droplet.vm[each.key].ipv4_address
  ttl     = 1     # 1 = automatic
  proxied = false # DNS-only; set true to route traffic through Cloudflare's proxy/CDN
  comment = "Managed by Terraform"
}
