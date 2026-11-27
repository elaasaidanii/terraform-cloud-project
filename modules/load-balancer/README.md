# Module load-balancer

Application Load Balancer public, listener HTTP et Target Group avec health check.

## Utilisation

    module "load_balancer" {
      source = "../../modules/load-balancer"

      project_name      = "cloud5"
      environment       = "dev"
      vpc_id            = module.network.vpc_id
      public_subnet_ids = module.network.public_subnet_ids
      security_group_id = module.security.alb_security_group_id
    }

## Entrees

| Nom | Type | Defaut | Description |
|---|---|---|---|
| `project_name` | string | aucun | Prefixe de nommage |
| `environment` | string | aucun | `dev`, `test` ou `prod` |
| `vpc_id` | string | aucun | VPC cible |
| `public_subnet_ids` | list(string) | aucun | Sous-reseaux publics (deux zones) |
| `security_group_id` | string | aucun | Security Group de l'ALB |
| `health_check_path` | string | `/` | Chemin du health check |

## Sorties

| Nom | Description |
|---|---|
| `alb_dns_name` | URL de l'application |
| `target_group_arn` | Target Group pour l'Auto Scaling Group |

## Cout

L'ALB est facture a l'heure des sa creation (environ 0,0225 $/h d'apres notre estimation).
