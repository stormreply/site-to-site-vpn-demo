output "igw" {
  value = aws_internet_gateway.this
}

output "route-table" {
  value = aws_route_table.this
}

output "security-group" {
  value = aws_security_group.this
}

output "subnet" {
  value = aws_subnet.this
}

output "vpc" {
  value = aws_vpc.this
}
