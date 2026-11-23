# Décisions d'architecture (ADR)

## ADR-001 : Page web servie par les instances

- **Choix :** une page HTML statique générée par `user_data`, affichant l'environnement, l'ID de l'instance et sa zone de disponibilité (via IMDSv2).
- **Raison :** rend visibles la répartition de charge et la tolérance aux pannes, sans code applicatif. Le projet porte sur l'infrastructure.
- **Options rejetées :**
  - Page minimale « Hello » : trop pauvre pour démontrer la répartition.
  - Application Flask/Node + RDS : hors périmètre et trop longue pour 22 jours.
