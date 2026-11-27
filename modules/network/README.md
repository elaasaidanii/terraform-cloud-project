# Module network

Crée le réseau : VPC, 2 sous-réseaux publics, 2 sous-réseaux privés applicatifs, 2 sous-réseaux privés pour la base de données, Internet Gateway, un NAT Gateway unique et les tables de routage.

## Utilisation

```hcl
module "network" {
  source = "../../modules/network"

  project_name             = "cloud5"
  environment              = "dev"
  azs                      = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs      = ["10.20.1.0/24", "10.20.2.0/24"]
  private_app_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
  private_db_subnet_cidrs  = ["10.20.21.0/24", "10.20.22.0/24"]
}
```

## Entrées

| Nom | Type | Défaut | Description |
|---|---|---|---|
| `project_name` | string | aucun | Préfixe de nommage |
| `environment` | string | aucun | `dev`, `test` ou `prod` |
| `vpc_cidr` | string | `10.20.0.0/16` | CIDR du VPC |
| `azs` | list(string) | aucun | Deux zones de disponibilité |
| `public_subnet_cidrs` | list(string) | aucun | CIDR des sous-réseaux publics |
| `private_app_subnet_cidrs` | list(string) | aucun | CIDR des sous-réseaux applicatifs |
| `private_db_subnet_cidrs` | list(string) | aucun | CIDR des sous-réseaux de base de données |

## Sorties

| Nom | Description |
|---|---|
| `vpc_id` | Identifiant du VPC |
| `vpc_cidr` | CIDR du VPC |
| `public_subnet_ids` | Sous-réseaux publics (ALB) |
| `private_app_subnet_ids` | Sous-réseaux applicatifs (Auto Scaling) |
| `private_db_subnet_ids` | Sous-réseaux de base de données (RDS) |
| `nat_gateway_id` | NAT Gateway |

## Coûts

Le NAT Gateway est facturé à l'heure dès sa création (environ 0,045 $/h d'après notre estimation). À détruire en fin de séance.

## Choix

- Un seul NAT Gateway, en zone a, pour limiter les coûts : si cette zone tombe, les instances de la zone b perdent leur sortie Internet.
- Les sous-réseaux de base de données n'ont aucune route vers Internet.
