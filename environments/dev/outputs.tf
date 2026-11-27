output "vpc_id" {
  description = "Identifiant du VPC."
  value       = module.network.vpc_id
}

output "nat_gateway_id" {
  description = "Identifiant du NAT Gateway."
  value       = module.network.nat_gateway_id
}

output "alb_dns_name" {
  description = "URL de l'application."
  value       = module.load_balancer.alb_dns_name
}
