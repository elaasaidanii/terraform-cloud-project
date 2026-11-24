# Jour 3 : script de bootstrap du backend

**Ce que j'ai construit :** `scripts/bootstrap-backend.sh`, un script idempotent qui crée et vérifie le bucket S3 du state Terraform (versioning, chiffrement, accès public bloqué).

**Ce que j'ai appris :**
- L'idempotence : un script qu'on peut relancer sans effet de bord
- `set -euo pipefail` pour arrêter un script à la première erreur
- Le workflow branche, Pull Request, merge, même en travaillant seule
- Vérifier le compte AWS actif : le nom du bucket dépend du numéro de compte

**Problème rencontré et solution :** `aws s3 ls` ne montrait aucun bucket car j'étais connectée à un autre compte AWS. Solution : comparer les derniers chiffres de `aws sts get-caller-identity` avant de conclure que des ressources ont disparu.

**Commande à retenir :** `aws s3api head-bucket --bucket NOM` pour tester l'existence d'un bucket.

**Capture :** `docs/screenshots/jour-03-bootstrap-script.png` (compte remplacé par une valeur fictive).
