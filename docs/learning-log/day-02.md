# Jour 2 : Terraform 101 et backend S3

**Ce que j'ai construit :** un backend Terraform distant (bucket S3 versionné, chiffré, sans accès public), créé avec l'AWS CLI, et testé depuis un projet bac à sable.

**Ce que j'ai appris :**
- Le cycle init, fmt, validate, plan, apply, destroy
- Le state : la mémoire de Terraform, stockée ici dans S3
- Pourquoi un backend distant : state partagé, chiffré, versionné et verrouillé
- Une SCP (service control policy) est une règle d'organisation AWS qu'on ne peut pas contourner
- Un fichier `.terraform.lock.hcl` fixe la version du provider

**Problème rencontré et solution :** la SCP du Learner Lab bloque `s3:GetBucketObjectLockConfiguration`, appelée par `aws_s3_bucket` après création. Solution : créer le bucket avec `aws s3api`. Détails dans `docs/troubleshooting.md` et `docs/decisions.md` (ADR-002).

**Commande à retenir :** `aws s3 ls | grep cloud5 | awk '{print $3}'` pour récupérer un nom de bucket.

**Captures :** `docs/screenshots/jour-02-*.png` (numéro de compte remplacé par une valeur fictive).
