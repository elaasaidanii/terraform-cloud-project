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
  description = "Identifiant du VPC (sortie du module network)."
  type        = string
}

variable "alb_ingress_cidr" {
  description = "Plage autorisee a joindre le load balancer en HTTP."
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrhost(var.alb_ingress_cidr, 0))
    error_message = "alb_ingress_cidr doit etre un bloc CIDR valide."
  }
}

variable "app_port" {
  description = "Port HTTP des instances applicatives."
  type        = number
  default     = 80

  validation {
    condition     = var.app_port > 0 && var.app_port < 65536
    error_message = "app_port doit etre un port valide."
  }
}

variable "db_port" {
  description = "Port de la base de donnees (5432 pour PostgreSQL)."
  type        = number
  default     = 5432

  validation {
    condition     = var.db_port > 0 && var.db_port < 65536
    error_message = "db_port doit etre un port valide."
  }
}
