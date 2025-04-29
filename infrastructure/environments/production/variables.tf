variable "hetzner_token" {
  sensitive   = true
  description = "Hetzner API token for Terraform access"
  type        = string
  nullable    = false
}

variable "postgres_password" {
  description = "Password for the PostgreSQL 'postgres' user"
  type        = string
  sensitive   = true
}
