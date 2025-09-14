<?php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "calculator_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$result = $conn->query("SELECT expression, result FROM history ORDER BY created_at DESC LIMIT 10");

$rows = [];
while ($row = $result->fetch_assoc()) {
  $rows[] = $row;
}

echo json_encode($rows);

$conn->close();
?>
