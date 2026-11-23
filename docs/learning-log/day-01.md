# Jour 1 : Setup

**Ce que j'ai construit :** environnement WSL2, outils (Git, Terraform, AWS CLI, GitHub CLI), dépôt GitHub et structure du projet.

**Ce que j'ai appris :**
- Travailler dans `~/projects` (disque Linux) plutôt que `/mnt/c`
- Le rôle du `.gitignore` : protéger les secrets avant le premier commit
- Pour AWS CLI et `gh`, on préfère les sources officielles à `apt` ou `snap`

**Problèmes rencontrés et solutions :** DNS de WSL, navigateur absent pour `gh auth login` (voir `docs/troubleshooting.md`).

**Commande à retenir :** `ping 8.8.8.8` puis `ping google.com` pour séparer un problème de réseau d'un problème de DNS.
