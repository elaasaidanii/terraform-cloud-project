#!/usr/bin/env bash
# Crée (ou vérifie) le bucket S3 qui stocke le state Terraform.
# Idempotent : peut être relancé sans danger.
set -euo pipefail

PROJECT="${PROJECT:-cloud5}"
REGION="${REGION:-us-east-1}"

log() { echo "[bootstrap] $*"; }

log "Vérification de la session AWS..."
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
BUCKET="${PROJECT}-tfstate-${ACCOUNT}"
log "Bucket cible : ${BUCKET}"

# 1. Création, seulement si le bucket n'existe pas
if aws s3api head-bucket --bucket "$BUCKET" 2>/dev/null; then
  log "Le bucket existe déjà : on vérifie sa configuration."
else
  log "Création du bucket..."
  aws s3api create-bucket --bucket "$BUCKET" --region "$REGION"
fi

# 2. Versioning : permet de récupérer un ancien state
log "Activation du versioning..."
aws s3api put-bucket-versioning --bucket "$BUCKET" \
  --versioning-configuration Status=Enabled

# 3. Chiffrement au repos
log "Activation du chiffrement AES256..."
aws s3api put-bucket-encryption --bucket "$BUCKET" \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# 4. Aucun accès public
log "Blocage de l'accès public..."
aws s3api put-public-access-block --bucket "$BUCKET" \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

# 5. Vérification finale
log "Vérification finale..."
VERSIONING=$(aws s3api get-bucket-versioning --bucket "$BUCKET" --query Status --output text)
ENCRYPTION=$(aws s3api get-bucket-encryption --bucket "$BUCKET" \
  --query 'ServerSideEncryptionConfiguration.Rules[0].ApplyServerSideEncryptionByDefault.SSEAlgorithm' --output text)
PUBLIC=$(aws s3api get-public-access-block --bucket "$BUCKET" \
  --query 'PublicAccessBlockConfiguration.BlockPublicPolicy' --output text)

echo
echo "  Versioning          : ${VERSIONING}"
echo "  Chiffrement         : ${ENCRYPTION}"
echo "  Accès public bloqué : ${PUBLIC}"
echo

if [[ "$VERSIONING" == "Enabled" && "$ENCRYPTION" == "AES256" && "$PUBLIC" == "True" ]]; then
  log "OK. Bloc backend à utiliser dans les environnements :"
  cat << BACKEND

  backend "s3" {
    bucket       = "${BUCKET}"
    key          = "<env>/terraform.tfstate"
    region       = "${REGION}"
    encrypt      = true
    use_lockfile = true
  }
BACKEND
else
  log "ERREUR : la configuration du bucket est incomplète."
  exit 1
fi
