output "vpn_config" {
  sensitive = false
  value     = nonsensitive(aws_vpn_connection.vpn.customer_gateway_configuration)
}
