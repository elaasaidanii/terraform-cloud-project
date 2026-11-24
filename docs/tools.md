# Les outils et leur rôle

| Outil | Analogie | Rôle dans le projet |
|---|---|---|
| WSL2 (Ubuntu) | Un Linux dans Windows | Environnement de travail identique à un serveur |
| Git / GitHub | La machine à remonter le temps | Historique du code, revue par Pull Request |
| GitHub CLI (`gh`) | Git/GitHub sans quitter le terminal | Créer le dépôt, gérer les secrets |
| Terraform | Le plan de l'architecte | Décrire l'infrastructure en code et la construire |
| AWS CLI | La télécommande | Vérifier ce qui existe réellement sur AWS |

## Outils à venir

| Outil | Rôle | Niveau |
|---|---|---|
| TFLint | Correcteur d'orthographe Terraform | Modules |
| Checkov | Détecte les failles de sécurité dans le code | Pipeline |
| Gitleaks | Empêche la fuite de secrets | Pipeline |
| Infracost | Affiche le coût d'un changement | Pipeline |

## Ajouts du Jour 3

| Outil | Rôle |
|---|---|
| Bash (`scripts/bootstrap-backend.sh`) | Rend la création du backend rejouable et vérifiable |
| `aws s3api` | Commandes S3 de bas niveau (création, versioning, chiffrement) |
