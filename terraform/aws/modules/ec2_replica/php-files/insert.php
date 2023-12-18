<?php

$host = getenv("DB_HOST");
$dbname = getenv("DB_NAME");
$username = getenv("DB_USER");
$password = getenv("DB_PASSWORD");

if(isset($_GET['firstname']) && isset($_GET['lastname'])){
  try {
  // se connecter à mysql
  $pdo = new PDO("mysql:host=$host;dbname=$dbname","$username","$password");
  } catch (PDOException $exc) {
    echo $exc->getMessage();
    exit();
  }

  // récupérer les valeurs 
  $firstname = $_GET['firstname'];
  $lastname = $_GET['lastname'];

  // Requête mysql pour insérer des données
  $sql = "INSERT INTO `user`(`firstname`, `lastname`) VALUES (:firstname,:lastname)";
  $res = $pdo->prepare($sql);
  $exec = $res->execute(array(":firstname"=>$firstname,":lastname"=>$lastname));

  // vérifier si la requête d'insertion a réussi
  if($exec){
    echo 'Données insérées';
  }else{
    echo "Échec de l'opération d'insertion";
  }
} else {
    echo 'Pas de données inséré';
}
?>

<div style="display: flex; flex-direction: row">
    <a href="/">Home</a>
    <a href="/view.php">View</a>
    <a href="/insert.php">Insert</a>
</div>