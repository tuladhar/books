output "droplet_ids" {
  description = "IDs of the droplets, keyed by droplet key"
  value       = { for key, droplet in digitalocean_droplet.vm : key => droplet.id }
}

output "droplet_ipv4_addresses" {
  description = "Public IPv4 addresses of the droplets, keyed by droplet key"
  value       = { for key, droplet in digitalocean_droplet.vm : key => droplet.ipv4_address }
}

output "droplet_statuses" {
  description = "Statuses of the droplets, keyed by droplet key"
  value       = { for key, droplet in digitalocean_droplet.vm : key => droplet.status }
}
