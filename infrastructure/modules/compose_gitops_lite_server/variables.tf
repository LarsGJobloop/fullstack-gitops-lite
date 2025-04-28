variable "name" {
  description = "Name of application"
  type        = string
}

variable "location" {
  description = "The datacenter location"
  type        = string
}

variable "instance_type" {
  description = "The type of machine to use"
  type        = string
}

variable "network_id" {
  description = "The network configuration to pass in"
  type        = number
}

variable "network_ip" {
  description = "The network configuration to pass in"
  type        = string
}

variable "git_repository" {
  description = "Git repository to source compose file from"
  type        = string
  nullable    = false
}

variable "git_access_token" {
  sensitive   = true
  description = "Optional for private Git repositories. With, at least, content read right"
  type        = string
  nullable    = true
}
