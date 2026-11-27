variable "project_name" {
  description = "Prefixe de nommage des ressources."
  type        = string
}

variable "environment" {
  description = "Nom de l'environnement : dev, test ou prod."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment doit valoir dev, test ou prod."
  }
}

variable "vpc_id" {
  description = "Identifiant du VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "Sous-reseaux publics dans lesquels placer l'ALB (un par zone)."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "L'ALB necessite au moins deux sous-reseaux dans deux zones."
  }
}

variable "security_group_id" {
  description = "Security Group du load balancer."
  type        = string
}

variable "health_check_path" {
  description = "Chemin interroge par le health check."
  type        = string
  default     = "/"
}
