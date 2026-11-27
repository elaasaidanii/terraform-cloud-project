variable "project_name" {
  description = "Préfixe de nommage des ressources (ex : cloud5)."
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

variable "vpc_cidr" {
  description = "Bloc CIDR principal du VPC."
  type        = string
  default     = "10.20.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr doit être un bloc CIDR valide."
  }
}

variable "azs" {
  description = "Les deux zones de disponibilité utilisées."
  type        = list(string)

  validation {
    condition     = length(var.azs) == 2
    error_message = "Le projet utilise exactement deux zones de disponibilité."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR des sous-réseaux publics (un par zone)."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2 && alltrue([for c in var.public_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "Deux CIDR valides sont attendus pour les sous-réseaux publics."
  }
}

variable "private_app_subnet_cidrs" {
  description = "CIDR des sous-réseaux privés applicatifs (un par zone)."
  type        = list(string)

  validation {
    condition     = length(var.private_app_subnet_cidrs) == 2 && alltrue([for c in var.private_app_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "Deux CIDR valides sont attendus pour les sous-réseaux applicatifs."
  }
}

variable "private_db_subnet_cidrs" {
  description = "CIDR des sous-réseaux privés de la base de données (un par zone)."
  type        = list(string)

  validation {
    condition     = length(var.private_db_subnet_cidrs) == 2 && alltrue([for c in var.private_db_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "Deux CIDR valides sont attendus pour les sous-réseaux de la base de données."
  }
}
