<?php
    $mysqli = new mysqli("localhost", "frasolmun", "OdsLxOdR7CJGu2z7hy4p", "frasolmun");
    $query = "SELECT * FROM `disco` ORDER BY idproducto DESC LIMIT 2";
    $res=$mysqli->query($query);
    $datosgen = [];
    $idproducto = [];
    while ($fila = $res->fetch_assoc()) {
        array_push($datosgen,$fila);
        array_push($idproducto,$fila['idproducto']);
    }
    $query = "SELECT pista_disco.idproducto,pista.numero,pista.artista,pista.titulo,pista.duracion FROM pista LEFT JOIN pista_disco ON pista.idpista = pista_disco.idpista WHERE pista_disco.idproducto IN (".implode(",",$idproducto).") ORDER BY idproducto DESC";
    $res=$mysqli->query($query);
    $datostracks = [];
    while ($fila = $res->fetch_assoc()) {
        array_push($datostracks,$fila);
    }
    $result['datosgen'] = $datosgen;
    $result['datostracks'] = $datostracks;
    print(json_encode($result));
?>