# Choix de securite

## Security Groups en chaine

| Groupe | Entrant | Justification |
|---|---|---|
| ALB | HTTP depuis Internet | Seul point d'entree public |
| App | Port 80 depuis le groupe ALB uniquement | Les instances ne sont pas joignables directement |
| DB | PostgreSQL depuis le groupe App uniquement | La base n'est pas accessible depuis Internet |

## Acces administratif

Aucun port SSH n'est ouvert. Aucune administration directe n'est necessaire pour le projet.

## Secrets

Aucun secret dans Git : `terraform.tfvars` est ignore, le mot de passe de la base sera genere hors du depot, et les identifiants AWS restent dans `~/.aws/credentials` ou dans les secrets du pipeline.

## Limites du Learner Lab

| Exigence du sujet | Adaptation |
|---|---|
| Roles IAM de moindre privilege | Creation impossible : reutilisation de `LabRole` et `LabInstanceProfile` |
| Identite federee du pipeline | OIDC indisponible : secrets GitHub (prevu par le sujet en repli) |
| Bucket S3 via la ressource `aws_s3_bucket` | Bloque par une SCP : voir `docs/decisions.md` (ADR-002) |
| HTTPS | Demande un certificat et un domaine : HTTP uniquement, limite documentee |
