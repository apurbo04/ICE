<?php
$host = "localhost";
$user = "root";   // default in XAMPP
$pass = "";       // empty in XAMPP
$db   = "calculator_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$expression = $_POST['expression'] ?? '';
$result = $_POST['result'] ?? '';

if ($expression !== '' && $result !== '') {
  $stmt = $conn->prepare("INSERT INTO history (expression, result) VALUES (?, ?)");
  $stmt->bind_param("ss", $expression, $result);
  $stmt->execute();
  $stmt->close();
}

$conn->close();
?>
