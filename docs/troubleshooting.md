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
