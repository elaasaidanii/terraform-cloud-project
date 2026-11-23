# Terraform Cloud Project

Plateforme AWS haute disponibilité, déployée avec Terraform et pilotée par un pipeline GitHub Actions.

> Projet en cours de construction (22 jours). Ce dépôt se remplit au fil des niveaux.

## Objectifs

- Modules Terraform réutilisables (réseau, sécurité, load balancer, compute, base de données, stockage)
- Environnements dev / test / prod avec états séparés
- Backend distant S3 chiffré et verrouillé
- Pipeline CI/CD : fmt, validate, plan, apply avec approbation manuelle

## Avancement

| Niveau | Module | Statut |
|---|---|---|
| 0 | Setup | Terminé |
| 1 | Backend S3 | À faire |
| 2 | Network | À faire |
| 3 | Security | À faire |
| 4 | Load balancer | À faire |
| 5 | Compute | À faire |
| 6 | Database | À faire |
| 7 | Storage | À faire |
| 8 | Pipeline CI/CD | À faire |

## Documentation

- [Les outils et leur rôle](docs/tools.md)
- [Dépannage](docs/troubleshooting.md)
- [Journal d'apprentissage](docs/learning-log/)

## Contraintes AWS Academy

Ce projet tourne sur un Learner Lab : pas de création de rôles IAM (usage de `LabRole`), pas de fédération OIDC (secrets GitHub), région us-east-1. Ces choix seront détaillés dans `docs/decisions.md`.
