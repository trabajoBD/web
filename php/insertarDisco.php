<?php
    //Inserta un disco en la base de datos
    $artista = $_POST['artista'];
    $album = $_POST['album'];
    $anho = $_POST['anho'];
    $duracion = $_POST['duracion'];
    $genero = $_POST['genero'];
    $arrayTracks = $_POST['arrayTracks'];
    $mysqli = new mysqli("localhost", "frasolmun", "OdsLxOdR7CJGu2z7hy4p", "frasolmun");
    //Artículo
    $query= "INSERT INTO `articulo`(`nombre`, `descripcion`, `preciooffline`, `precioonline`, `disponibleonline`, `disponibleoffline`, `imagen`) VALUES ".
            "('".mysqli_real_escape_string($mysqli,$artista)." - ".mysqli_real_escape_string($mysqli,$album)."','',0,0,0,0,'')";
    $mysqli->query($query);
    $idarticulo=$mysqli->insert_id;
    //Producto
    $query="INSERT INTO `producto`(`idarticulo`) VALUES (".$idarticulo.")";
    $mysqli->query($query);
    $idproducto=$mysqli->insert_id;
    
    //Disco
    $query= "INSERT INTO `disco`(`idproducto`,`artista`, `album`, `anho`, `duracion`, `genero`) VALUES ".
            "(".$idproducto.",'".mysqli_real_escape_string($mysqli,$artista)."','".mysqli_real_escape_string($mysqli,$album)."',".$anho.",".$duracion.",'".mysqli_real_escape_string($mysqli,$genero)."')";
    $mysqli->query($query);
    
    //Tracks
    $query= "INSERT INTO `pista`(`numero`, `artista`, `titulo`, `duracion`) VALUES";
    foreach ($arrayTracks as $track)
        $query .= " (".($track[0]+1).",'".mysqli_real_escape_string($mysqli,$track[1])."','".mysqli_real_escape_string($mysqli,$track[2])."',".$track[3]."),";
    $query=substr_replace($query ,"",-1);
    $mysqli->query($query);
    print_r($query);
    $idpistap=$mysqli->insert_id;
    
    $query= "INSERT INTO `pista_disco`(`idproducto`, `idpista`) VALUES";
    for($i=0;$i<count($arrayTracks);$i++)
        $query.=" (". $idproducto .",". ($idpistap+$i) ."),";
    $query=substr_replace($query,"",-1);
    $mysqli->query($query);
?>