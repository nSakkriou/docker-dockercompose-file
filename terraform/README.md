```
terraform init 
```
Pour importer les modules des providers qu'il detecte dans nos fichiers
Tous les fichiers .tf seront lu. On peut les 

```
terraform plan 
```
Nous montre a quoi va ressembler notre archi, comme une compilation du code pour verifier les erreurs aussi

```
terraform apply 
```
Permet d'appliquer les modifs et donc de créer / modifier les ressources voulus

```
terraform destroy 
```


Pour générer les access token :
Azure :
Microsoft Entra -> Inscription d'application -> Nouvelle inscription
Sur cette inscription -> Certificats et secret
Abonnement -> MOn abonnement -> Controle d'acces IAM -> Ajouter un role assignment -> ROle d'admin priviligé -> Contributeur


terraform.tfvars = Fichier que l'on peut mettre dans le gitignore, on va y noter nos credentials. Permet de fill les varialbles contenues dans le vars.tf ayant le même nom.

vars.tf