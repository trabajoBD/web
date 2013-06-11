<?php
    $mysqli = new mysqli("localhost", "frasolmun", "OdsLxOdR7CJGu2z7hy4p", "frasolmun");
    $mysqli->set_charset("utf8");
    $query = "SELECT * FROM `disco` ORDER BY idproducto DESC LIMIT 9";
    $res=$mysqli->query($query);
    $datosgen = [];
    $idproducto = [];
    while ($fila = $res->fetch_assoc()) {
        array_push($datosgen,$fila);
        array_push($idproducto,$fila['idproducto']);
    }
    for ($i=0;$i<count($datosgen);$i++) $datosgen[$i]['datostracks'] = [];
    $query = "SELECT pista_disco.idproducto,pista.numero,pista.artista,pista.titulo,pista.duracion FROM pista LEFT JOIN pista_disco ON pista.idpista = pista_disco.idpista WHERE pista_disco.idproducto IN (".implode(",",$idproducto).") ORDER BY idproducto DESC, pista.numero ASC";
    $res=$mysqli->query($query);
    while ($fila = $res->fetch_assoc()) {
        array_push($datosgen[array_keys($idproducto,$fila['idproducto'])[0]]['datostracks'],$fila);
    }
    print(json_encode($datosgen));
?>