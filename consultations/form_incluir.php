<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>
<head><title>Incluir/Editar um cliente.</title></head>
<body>
<form name="form1" method="POST" action="incluir.php">
<?php
if (isset($_GET["codigo"])) {
    include("./config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);
?>
    <center><h3>Editar Cliente</h3></center>
<?php
    $sql = "SELECT * FROM Cliente WHERE idCliente=" . $_GET['codigo'];
    $result = mysqli_query($con, $sql);
    $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
    mysqli_close($con);
?>
    <input type="hidden" name="codigo" value="<?php echo $_GET['codigo']; ?>">
<?php
} else {
?>
    <center><h3>Cadastrar Novo Cliente</h3></center>
<?php
}
?>
<table border="0" align="center" width="35%">
<tr><td width="20%">Nome:</td>
    <td colspan="2" width="90%">
      <input type="text" name="nome" value="<?php echo @$vetor['nome']; ?>" maxlength="80" size="31">
    </td>
</tr>
<tr><td>CPF:</td>
    <td colspan="2"><input type="text" name="CPF" value="<?php echo @$vetor['CPF']; ?>" maxlength="11" size="31"></td>
</tr>
<tr><td>Logradouro:</td>
    <td colspan="2"><input type="text" name="logradouro" value="<?php echo @$vetor['logradouro']; ?>" maxlength="40" size="31"></td>
</tr>
<tr><td>Número:</td>
    <td colspan="2"><input type="text" name="numero" value="<?php echo @$vetor['numero']; ?>" maxlength="4" size="31"></td>
</tr>
<tr><td>CEP:</td>
    <td colspan="2"><input type="text" name="CEP" value="<?php echo @$vetor['CEP']; ?>" maxlength="8" size="31"></td>
</tr>
<tr><td>Bairro:</td>
    <td colspan="2"><input type="text" name="bairro" value="<?php echo @$vetor['bairro']; ?>" maxlength="30" size="31"></td>
</tr>
<tr><td>Cidade:</td>
    <td colspan="2"><input type="text" name="cidade" value="<?php echo @$vetor['cidade']; ?>" maxlength="30" size="31"></td>
</tr>
<tr><td>Estado:</td>
    <td colspan="2"><input type="text" name="estado" value="<?php echo @$vetor['estado']; ?>" maxlength="2" size="31"></td>
</tr>
<tr><td colspan="3" align="center">
      <input type="button" value="Cancelar" onclick="location.href='index.php'">
      <input type="submit" value="Gravar">
    </td>
</tr>
</table>
</form>
</body>
</html>
