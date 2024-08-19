<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM Cliente WHERE idCliente=" . $_GET["codigo"];
mysqli_query($con, $sql);
mysqli_close($con);
header("location: ./index.php");
?>
