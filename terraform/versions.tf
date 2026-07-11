terraform {
  required_version = ">= 1.10.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.95"
    }
  }

  # Cloudflare R2 as state backend (S3-compatible).
  # Bucket and endpoint are supplied at init time:
  #   - CI:    -backend-config="bucket=..." + AWS_ENDPOINT_URL_S3 env var
  #   - Local: terraform init -backend-config=backend.hcl (see backend.hcl.example)
  # R2 credentials come from AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY env vars.
  backend "s3" {
    key                         = "digitalocean-vm/terraform.tfstate"
    region                      = "auto"
    use_lockfile                = true
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
