<?php
header("Content-Type: text/html; charset=utf-8", true);
?>
<html>
  <head>
    <title>Lista de Clientes</title>
    <style>
          .tituloColuna {
              color: black;
              text-align: center;
          }
          .tituloCelula {
              background-color: #581845;
              text-align: center;
          }
      </style>
  </head>
  <body>
    <center><h3 style="color:#660014; font-size: 26px;">Lista de Clientes</h3></center>
    <form name="form1" method="POST" action="form_incluir.php">
      <table border="0" align="center" width="100%">
      <?php
      include("./config.php");
      $con = mysqli_connect($host, $login, $senha, $bd);
      $sql = "SELECT * FROM Cliente ORDER BY nome";
      $tabela = mysqli_query($con, $sql);

      if (mysqli_num_rows($tabela) == 0) {
      ?>
          <tr><td align="center">Não há nenhum cliente cadastrado.</td></tr>
          <tr><td align="center"><input type="submit" value="Incluir Cliente"></td></tr>
      <?php
      } else {
      ?>
          <tr style="color: white;"> 
            <td class="tituloCelula" width="15%">Nome</td>
            <td class="tituloCelula" width="10%">CPF</td>
            <td class="tituloCelula" width="15%">Logradouro</td>
            <td class="tituloCelula" width="5%">Número</td>
            <td class="tituloCelula" width="10%">CEP</td>
            <td class="tituloCelula" width="10%">Bairro</td>
            <td class="tituloCelula" width="10%">Cidade</td>
            <td class="tituloCelula" width="5%">Estado</td>
            <td class="tituloCelula" width="20%"></td>
          </tr>
      <?php
          while ($dados = mysqli_fetch_row($tabela)) {
      ?>
          <tr><td class="tituloColuna"><?php echo $dados[2]; ?></td>
              <td class="tituloColuna"><?php echo $dados[1]; ?></td>
              <td class="tituloColuna"><?php echo $dados[3]; ?></td>
              <td class="tituloColuna"><?php echo $dados[4]; ?></td>
              <td class="tituloColuna"><?php echo $dados[5]; ?></td>
              <td class="tituloColuna"><?php echo $dados[6]; ?></td>
              <td class="tituloColuna"><?php echo $dados[7]; ?></td>
              <td class="tituloColuna"><?php echo $dados[8]; ?></td>
              <td align="center">
                  <input style="background-color: #581845; color:#ff7400;" type="button" value="Excluir" onclick="location.href='excluir.php?codigo=<?php echo $dados[0]; ?>'">
                  <input style="background-color: #581845; color:#ff7400;" type="button" value="Editar" onclick="location.href='form_incluir.php?codigo=<?php echo $dados[0]; ?>'">
              </td>
          </tr>
      <?php
          }
      ?>
          <tr bgcolor="grey"><td colspan="9" height="5"></td></tr>
      <?php
          mysqli_close($con);
      ?>
          <tr>
            <td colspan="9" align="center">
              <input type="submit" value="Incluir Novo Cliente" style="margin-top: 20px; background-color: #581845; color:#ff7400;">
            </td>
          </tr>
      <?php
      }
      ?>
      </table>
    </form>
  </body>
</html>
