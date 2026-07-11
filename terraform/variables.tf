variable "do_token" {
  description = "DigitalOcean API token (set via TF_VAR_do_token or DIGITALOCEAN_TOKEN)"
  type        = string
  sensitive   = true
  default     = null
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token with DNS edit access (or set CLOUDFLARE_API_TOKEN)"
  type        = string
  sensitive   = true
  default     = null
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for purutuladhar.com"
  type        = string
}
