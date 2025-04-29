output "service_info" {
  value = module.compose_server.server_info
}

output "postgresql_info" {
  value = module.postgresql.server_info
}
