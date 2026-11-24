variable "project_name" {
  description = "Préfixe de nommage"
  type        = string
}

variable "environment" {
  description = "dev, test ou prod"
  type        = string
}

variable "vpc_cidr" {
  description = "Plage d'adresses du VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "azs" {
  description = "Les 2 zones de disponibilité"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_app_subnet_cidrs" {
  type = list(string)
}

variable "private_db_subnet_cidrs" {
  type = list(string)
}
