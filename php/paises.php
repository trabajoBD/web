<?php
    include_once('mysqlConectar.php');
    $query = "SELECT idpais AS 'value', nombrepais AS 'text' FROM `pais` ORDER BY nombrepais";
    $res=$mysqli->query($query);
    $paises = [];
    while ($fila = $res->fetch_assoc()) {
        array_push($paises,$fila);
    }
    print(json_encode($paises));
?>