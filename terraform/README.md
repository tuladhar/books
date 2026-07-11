# DigitalOcean VM with Terraform

Provisions a DigitalOcean droplet, with Terraform state stored in Cloudflare R2
(via the S3-compatible backend, with native state locking).

## Layout

| File | Purpose |
| --- | --- |
| `versions.tf` | Terraform/provider versions + R2 backend config |
| `main.tf` | Provider + droplet resource |
| `variables.tf` | Droplet name/region/size/image/tags |
| `outputs.tf` | Droplet ID, IPv4/IPv6, status |
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
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare account ID (forms the R2 endpoint URL) |
| `R2_BUCKET` | Name of the R2 bucket holding the state |
