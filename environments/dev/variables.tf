variable "aws_region" {
  description = "Région AWS de déploiement."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nom de l'environnement."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Préfixe de nommage des ressources."
  type        = string
  default     = "cloud5"
}

variable "owner" {
  description = "Propriétaire des ressources (tag Owner)."
  type        = string
}

variable "vpc_cidr" {
  description = "Bloc réseau principal."
  type        = string
  default     = "10.20.0.0/16"
}
