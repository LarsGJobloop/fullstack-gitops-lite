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
  type        = string
}

variable "hostname" {
  description = "Hostname to use for server"
  type        = string
  nullable    = false
}

variable "labels" {
  description = "Labels to annotate the server with"
  type        = map(string)
  nullable    = true
}

variable "postgres_password" {
  description = "Password for the PostgreSQL 'postgres' user"
  type        = string
  sensitive   = true
}

variable "data_delete_protection" {
  description = "Extra protection for the data volume"
  type        = bool
  default     = false
}
