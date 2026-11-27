output "vpc_id" {
  description = "Identifiant du VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "Bloc CIDR du VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Identifiants des sous-réseaux publics (ALB)."
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "Identifiants des sous-réseaux privés applicatifs (Auto Scaling)."
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "Identifiants des sous-réseaux privés de la base de données (RDS)."
  value       = aws_subnet.private_db[*].id
}

output "nat_gateway_id" {
  description = "Identifiant du NAT Gateway."
  value       = aws_nat_gateway.this.id
}
