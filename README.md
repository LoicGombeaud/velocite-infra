# infra

Infrastructure définie « as code » pour les projets Vélo-Cité

[Première utilisation](#première-utilisation)
- [Création du conteneur d'objects](#création-du-conteneur-dobjets)
- [Création d'un token OVH](#création-dun-token-ovh)
- [Installation de terraform](#installation-de-terraform)
- [Configuration du backend terraform et du provider OVH](#configuration-du-backend-terraform-et-du-provider-ovh)
- [Initialisation de terraform](#initialisation-de-terraform)
- [Premier terraform apply](#premier-terraform-apply)
- [Deuxième terraform apply](#deuxième-terraform-apply)

## Première utilisation

### Création du conteneur d'objets

Se connecter au compte OVH, et naviguer vers la section "Object Storage" :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/145dbada-b0ff-4652-8fa6-f24f9379e048) |
|-|

Cliquer sur "Créer un conteneur d'objets" :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/5bfd4f27-9d92-45c7-ac3a-898520654d75) |
|-|

Sélectionner l'offre "Standard Object Storage" :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/4bc816dc-641e-4e53-a3e2-af0416e8794a) |
|-|

Sélectionner la localisation "Gravelines" :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/22988fe8-4b24-460a-b354-5c096a39bdc4) |
|-|

Cliquer sur "Créer un utilisateur" :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/dee1ae2e-dfe3-4b74-a1d8-81beebed2330) |
|-|

Le nommer "terraform", et confirmer la création :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/45316fac-a9dd-401f-bd81-a0c9021b54a0) |
|-|

Noter quelque part la clé d'accès et la clé secrète (on s'en servira plus tard) :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/0a54d487-e0ff-4d1a-88ec-f23c32f59a88) |
|-|

Nommer le conteur "velo-cite", puis confirmer la création :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/465d4432-9fcf-4476-b9fe-3fc999c9a029) |
|-|

### Création d'un token OVH

Se rendre sur la [page de création de token OVH], et créer un token :
- nom : Terraform
- description : Terraform
- valididité : illimitée
- permissions : laisser tel quel (GET *, PUT *, POST *, DELETE *)

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/4d2be5cc-ba25-4351-8cf2-8b917925d48e) |
|-|

À l'écran suivant, noter quelque part la clé d'application, le secret d'application, et la clé de consommateur (on s'en servira plus tard) :

| ![image](https://github.com/LoicGombeaud/velocite-infra/assets/1173317/f10e4a52-9345-435c-b9f4-b563324ed9d3) |
|-|

### Installation de terraform

Installer terraform en suivant [les instructions officielles](https://developer.hashicorp.com/terraform/downloads)

### Configuration du backend terraform et du provider OVH

- cloner ce dépôt
- copier le fichier `ovh_config.sh.example` vers `ovh_config.sh`
- remplacer les valeurs de la clé d'accès et de la clé secrète
- remplacer les valeurs de la clés d'application, du secret d'application et de la clé consommateur
- exécuter `ovh_config.sh`

### Initialisation de terraform

Exécuter l'initialisation :
```
terraform init
```

### Premier terraform apply

La commande `terraform apply` permet de créer l'infrastructure définie « as code » dans ce module.

Sa toute première exécution est un peu particulière pour des raisons techniques*, il y a donc une manipulation un peu particulière à faire :
- dans le fichiers `providers.tf`, supprimer la section indiquée
- supprimer le fichier `argocd.tf`
- exécuter `terraform apply` en validant (taper `yes` dans le prompt)
- restaurer les fichiers `providers.tf` et `argocd.tf` (par exemple avec `git checkout -- providers.tf argocd.tf`)

\* <sup><sub>Deux des providers utilisés (`helm` et `kubernetes`) dépendent de ressources créées par le provider `ovh`, ceux-ci ne peuvent donc pas être configurés tant que ces ressources n'ont pas été créées.</sub></sup>

### Deuxième terraform apply

Exécuter un deuxième `terraform apply` pour finir de créer les ressources, en validant (taper `yes` dans le prompt).

À partir de maintenant, les modifications pourront se faire via un workflow terraform classique.
