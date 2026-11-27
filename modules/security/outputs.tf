output "alb_security_group_id" {
  description = "Security Group du load balancer."
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "Security Group des instances applicatives."
  value       = aws_security_group.app.id
}

output "db_security_group_id" {
  description = "Security Group de la base de donnees."
  value       = aws_security_group.db.id
}
