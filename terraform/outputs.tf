output "droplet_id" {
  description = "ID of the droplet"
  value       = digitalocean_droplet.vm.id
}

output "droplet_ipv4" {
  description = "Public IPv4 address of the droplet"
  value       = digitalocean_droplet.vm.ipv4_address
}

output "droplet_ipv6" {
  description = "Public IPv6 address of the droplet"
  value       = digitalocean_droplet.vm.ipv6_address
}

output "droplet_status" {
  description = "Status of the droplet"
  value       = digitalocean_droplet.vm.status
}
