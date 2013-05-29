<?php
    //Inserta un disco en la base de datos
    $artista = $_POST['artista'];
    $album = $_POST['album'];
    $anho = $_POST['anho'];
    $duracion = $_POST['duracion'];
    $genero = $_POST['genero'];
    $mysqli = new mysqli("localhost", "userweb01234", "EXMGvRp4aMNYyKyn", "videoclub");
    //Artículo
    $query= "INSERT INTO `articulo`(`nombre`, `descripcion`, `preciooffline`, `precioonline`, `disponibleonline`, `disponibleoffline`, `imagen`) VALUES ".
            "('".$artista." - ".$album."','',0,0,0,0,'')";
    $mysqli->query($query);
    $idarticulo=$mysqli->insert_id;
    print($query);
    //Producto
    $query="INSERT INTO `producto`(`idarticulo`) VALUES (".$idarticulo.")";
    $mysqli->query($query);
    $idproducto=$mysqli->insert_id;
    
    //Disco
    $query= "INSERT INTO `disco`(`idproducto`,`artista`, `album`, `anho`, `duracion`, `genero`) VALUES ".
            "(".$idproducto.",'".$artista."','".$album."',".$anho.",".$duracion.",'".$genero."')";
    $mysqli->query($query);
    
?>