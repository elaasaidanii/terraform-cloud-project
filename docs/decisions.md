# Décisions d'architecture (ADR)

## ADR-001 : Page web servie par les instances

- **Choix :** une page HTML statique générée par `user_data`, affichant l'environnement, l'ID de l'instance et sa zone de disponibilité (via IMDSv2).
- **Raison :** rend visibles la répartition de charge et la tolérance aux pannes, sans code applicatif. Le projet porte sur l'infrastructure.
- **Options rejetées :**
  - Page minimale « Hello » : trop pauvre pour démontrer la répartition.
  - Application Flask/Node + RDS : hors périmètre et trop longue pour 22 jours.

## ADR-002 : Backend S3 créé par script AWS CLI

- **Choix :** le bucket du state est créé avec `aws s3api` (script), puis utilisé comme backend Terraform avec `use_lockfile = true`.
- **Raison :** la SCP du Learner Lab interdit `s3:GetBucketObjectLockConfiguration`, que la ressource `aws_s3_bucket` appelle après création. Le backend S3 ne l'appelle pas, donc il fonctionne.
- **Options rejetées :**
  - Bootstrap Terraform (`aws_s3_bucket`) : bloqué par la SCP.
  - State local : perdu en cas de panne, non partageable avec le pipeline, secrets non protégés.
