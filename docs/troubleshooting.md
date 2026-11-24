# Dépannage : erreurs rencontrées et solutions

## WSL : "Could not resolve host"
- **Symptôme :** `curl: (6) Could not resolve host`
- **Cause :** résolution DNS défaillante dans WSL
- **Diagnostic :** `ping 8.8.8.8` répond mais `ping google.com` échoue
- **Solution :** `generateResolvConf = false` dans `/etc/wsl.conf` et DNS 8.8.8.8 / 1.1.1.1 dans `/etc/resolv.conf`

## AWS CLI : "Found preexisting AWS CLI installation"
- **Symptôme :** `Please rerun install script with --update flag`
- **Cause :** l'installation avait déjà réussi et je l'ai relancée
- **Solution :** vérifier avec `aws --version` avant de réinstaller ; utiliser `--update` pour mettre à jour

## GitHub CLI : "Failed opening a web browser"
- **Symptôme :** `executable file not found in $PATH` (xdg-open, wslview)
- **Cause :** WSL n'a pas de navigateur intégré
- **Solution :** ouvrir https://github.com/login/device dans le navigateur Windows et saisir le code affiché

## AWS CLI : "Unable to parse config file"
- **Symptôme :** `aws: [ERROR]: Unable to parse config file: ~/.aws/credentials`
- **Cause :** fichier credentials mal formé après le collage
- **Diagnostic :** `cut -c1-25 ~/.aws/credentials | cat -A` montre la structure sans exposer les secrets
- **Solution :** supprimer le fichier et recoller le bloc complet copié depuis AWS Details

## Terraform : S3 bloqué par une SCP (Learner Lab)
- **Symptôme :** `GetObjectLockConfiguration ... explicit deny in a service control policy`
- **Cause :** la ressource `aws_s3_bucket` lit l'Object Lock après création, action interdite par la SCP de l'organisation
- **Essais écartés :** provider 5.x épinglé, provider 6.x (même erreur)
- **Solution :** créer le bucket de backend avec `aws s3api`, puis l'utiliser comme backend Terraform (le backend S3 n'appelle pas cette action)

## Terraform : "locked provider ... does not match configured version constraint"
- **Symptôme :** `locked provider registry.terraform.io/hashicorp/aws 6.73.0 does not match configured version constraint ~> 5.0`
- **Cause :** `.terraform.lock.hcl` fixait une version après un test, puis j'ai changé la contrainte dans `main.tf`
- **Solution :** aligner la contrainte et lancer `terraform init -upgrade`

## AWS CLI : `aws s3 ls` n'affiche rien alors que le bucket existe
- **Symptôme :** aucune ressource visible après une reconnexion au Learner Lab
- **Cause :** les identifiants collés appartenaient à un autre compte AWS
- **Diagnostic :** comparer les 4 derniers chiffres de `aws sts get-caller-identity --query Account --output text`
- **Solution :** recoller les identifiants du bon compte
