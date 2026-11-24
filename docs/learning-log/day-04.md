# Jour 4 : module network (1/2)

**Ce que j'ai construit :** module `network` (VPC, 6 sous-réseaux, Internet Gateway, route table publique) appelé par `environments/dev`.

**Ce que j'ai appris :**
- Un module = variables (entrées), ressources, outputs (sorties)
- `count` crée plusieurs ressources similaires (un subnet par zone)
- Les 3 niveaux de sous-réseaux : public, app privé, base privée
- Le nom du bucket de backend est passé par `-backend-config`, sans numéro de compte dans le dépôt

**Problème rencontré et solution :** (à compléter)

**Commande à retenir :** `terraform fmt -recursive`
