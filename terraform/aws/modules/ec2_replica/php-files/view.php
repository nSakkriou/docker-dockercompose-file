<?php 
  $host = getenv("DB_HOST");
  $dbname = getenv("DB_NAME");
  $username = getenv("DB_USER");
  $password = getenv("DB_PASSWORD");
    
  $dsn = "mysql:host=$host;dbname=$dbname"; 
  // récupérer tous les utilisateurs
  $sql = "SELECT * FROM user";
   
  try{
   $pdo = new PDO($dsn, $username, $password);

   // SQL query to create the 'users' table
   $createTableQuery = "
   CREATE TABLE IF NOT EXISTS user (
       id INT AUTO_INCREMENT PRIMARY KEY,
       lastname VARCHAR(255) NOT NULL,
       firstname VARCHAR(255) NOT NULL
    )
  ";

  // Execute the query
  $pdo->exec($createTableQuery);

   $stmt = $pdo->query($sql);
   
   if($stmt === false){
    die("Erreur");
   }
   
  }catch (PDOException $e){
    echo $e->getMessage();
  }
?>

<!DOCTYPE html>
<html>
<body>
  <nav style="display: flex; flex-direction: row">
    <a href="/">Home</a>
    <a href="/view.php">View</a>
    <a href="/insert.php">Insert</a>
</nav>
  
 <h1>Liste des utilisateurs</h1>
 <table>
   <thead>
     <tr>
       <th>ID</th>
       <th>lastname</th>
       <th>firstname</th>
     </tr>
   </thead>
   <tbody>
     <?php while($row = $stmt->fetch(PDO::FETCH_ASSOC)) : ?>
     <tr>
       <td><?php echo htmlspecialchars($row['id']); ?></td>
       <td><?php echo htmlspecialchars($row['lastname']); ?></td>
       <td><?php echo htmlspecialchars($row['firstname']); ?></td>
     </tr>
     <?php endwhile; ?>
   </tbody>
 </table>
</body>
</html>
