# DigitalOcean VM with Terraform

Provisions a DigitalOcean droplet, with Terraform state stored in Cloudflare R2
(via the S3-compatible backend, with native state locking).

## Layout

| File | Purpose |
| --- | --- |
| `versions.tf` | Terraform/provider versions + R2 backend config |
| `main.tf` | Provider + droplet resource (`for_each` over `local.droplets`) |
| `dns.tf` | Cloudflare A record per droplet (name → droplet IPv4) |
| `locals.tf` | Droplet map + shared defaults — add a VM here |
| `variables.tf` | DigitalOcean token variable |
| `outputs.tf` | Droplet IDs, IPv4 addresses, statuses (maps) |
| `backend.hcl.example` | Template for local backend config |

## Local usage

```sh
# R2 credentials (S3 API token for the bucket)
export AWS_ACCESS_KEY_ID=<r2-access-key-id>
export AWS_SECRET_ACCESS_KEY=<r2-secret-access-key>

# DigitalOcean API token
export DIGITALOCEAN_TOKEN=<do-token>

cp backend.hcl.example backend.hcl   # fill in bucket + account ID
terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

## CI (GitHub Actions)

Two workflows run on every PR commit touching `terraform/**`:

- **Terraform Checks** (`terraform-checks.yml`) — `terraform fmt -check`,
  `terraform validate`, and `tflint`.
- **Terraform Plan** (`terraform-plan.yml`) — runs `terraform plan` against the
  R2-backed state and posts/updates a summary table comment on the PR.

### Required repository secrets

| Secret | Description |
| --- | --- |
| `DO_TOKEN` | DigitalOcean API token (read/write) |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 API token — Access Key ID |
| `R2_SECRET_ACCESS_KEY` | Cloudflare R2 API token — Secret Access Key |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare account ID (forms the R2 endpoint URL) — environment **variable** |
| `R2_BUCKET` | Name of the R2 bucket holding the state |
| `CLOUDFLARE_API_TOKEN` | Cloudflare API token with Zone → DNS → Edit on the zone |
| `CLOUDFLARE_ZONE_ID` | Zone ID of purutuladhar.com — environment **variable** |
