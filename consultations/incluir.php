<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);

if (isset($_POST["codigo"])) {
    $sql = "SELECT idCliente FROM Cliente WHERE idCliente=" . $_POST["codigo"];
    $result = mysqli_query($con, $sql);
    if (mysqli_num_rows($result) != 0) {
        $sql = "UPDATE Cliente SET nome='" . $_POST["nome"] . "', CPF='" . $_POST["CPF"] . "', logradouro='" . $_POST["logradouro"] . "', numero=" . $_POST["numero"] . ", CEP='" . $_POST["CEP"] . "', bairro='" . $_POST["bairro"] . "', cidade='" . $_POST["cidade"] . "', estado='" . $_POST["estado"] . "' WHERE idCliente=" . $_POST["codigo"];
    }
} else {
    $sql = "INSERT INTO Cliente (nome, CPF, logradouro, numero, CEP, bairro, cidade, estado) VALUES ('" . $_POST["nome"] . "', '" . $_POST["CPF"] . "', '" . $_POST["logradouro"] . "', " . $_POST["numero"] . ", '" . $_POST["CEP"] . "', '" . $_POST["bairro"] . "', '" . $_POST["cidade"] . "', '" . $_POST["estado"] . "')";
}

mysqli_query($con, $sql);
mysqli_close($con);
header("location: ./index.php");
?>
