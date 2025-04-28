variable "hetzner_token" {
  sensitive   = true
  description = "Hetzner API token for Terraform access"
  type        = string
  nullable    = false
}

variable "git_access_token" {
  sensitive   = true
  description = "Optional for private Git repositories. With, at least, content read right"
  type        = string
  nullable    = true
}
