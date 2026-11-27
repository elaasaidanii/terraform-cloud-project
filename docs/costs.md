# Estimation des coûts

Estimations approximatives (us-east-1), à comparer avec le coût réel en fin de projet.

| Ressource | Coût indicatif | Remarque |
|---|---|---|
| NAT Gateway | environ 0,045 $/h + trafic | Le plus coûteux du réseau : un seul NAT, détruit après chaque session de tests |
| Adresse IPv4 publique (EIP du NAT) | environ 0,005 $/h | Facturée même sans trafic |
| VPC, sous-réseaux, Internet Gateway, tables de routage | gratuit | |
| Bucket S3 du backend | quelques centimes/mois | Conservé |

## Maîtrise des coûts

- `terraform destroy` à la fin de chaque session de tests, avec vérification (NAT, EIP, VPC).
- Le code est validé avec `terraform plan`, qui ne crée rien et ne coûte rien.
- L'environnement `prod` est codé mais jamais déployé.
