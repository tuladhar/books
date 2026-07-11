variable "do_token" {
  description = "DigitalOcean API token (set via TF_VAR_do_token or DIGITALOCEAN_TOKEN)"
  type        = string
  sensitive   = true
  default     = null
}

variable "droplet_name" {
  description = "Name of the droplet"
  type        = string
  default     = "web-vm"
}

variable "droplet_region" {
  description = "DigitalOcean region slug"
  type        = string
  default     = "blr1"
}

variable "droplet_size" {
  description = "Droplet size slug"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "droplet_image" {
  description = "Droplet image slug"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "droplet_tags" {
  description = "Tags applied to the droplet"
  type        = list(string)
  default     = ["terraform", "web"]
}
