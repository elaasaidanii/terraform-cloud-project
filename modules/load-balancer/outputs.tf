output "alb_dns_name" {
  description = "Nom DNS de l'ALB (URL de l'application)."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN du Target Group (utilise par l'Auto Scaling Group)."
  value       = aws_lb_target_group.app.arn
}
