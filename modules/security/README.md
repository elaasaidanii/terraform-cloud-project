# Module security

Security Groups en chaine : Internet, ALB, application, base de donnees.

## Regles

| Groupe | Entrant | Sortant |
|---|---|---|
| ALB | HTTP (80) depuis `alb_ingress_cidr` | Port applicatif vers le groupe App |
| App | Port applicatif depuis le groupe ALB uniquement | Tout (installation via le NAT) |
| DB | Port base de donnees depuis le groupe App uniquement | Aucune |

## Utilisation

    module "security" {
      source = "../../modules/security"

      project_name = "cloud5"
      environment  = "dev"
      vpc_id       = module.network.vpc_id
    }

## Entrees

| Nom | Type | Defaut | Description |
|---|---|---|---|
| `project_name` | string | aucun | Prefixe de nommage |
| `environment` | string | aucun | `dev`, `test` ou `prod` |
| `vpc_id` | string | aucun | VPC cible |
| `alb_ingress_cidr` | string | `0.0.0.0/0` | Source autorisee vers l'ALB |
| `app_port` | number | `80` | Port des instances |
| `db_port` | number | `5432` | Port PostgreSQL |

## Sorties

| Nom | Description |
|---|---|
| `alb_security_group_id` | Groupe de l'ALB |
| `app_security_group_id` | Groupe des instances |
| `db_security_group_id` | Groupe de la base |

## Choix

- Aucun SSH : aucune administration directe n'est ouverte.
- Le HTTPS demande un certificat et un domaine : le projet expose le HTTP et documente cette limite.
- Les roles IAM ne sont pas crees dans le Learner Lab : `LabInstanceProfile` est reutilise par le module compute.
