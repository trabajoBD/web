<?php
    //Inserta una película en la base de datos
    $mysqli = new mysqli("localhost", "frasolmun", "OdsLxOdR7CJGu2z7hy4p", "frasolmun");
    $trailer                = mysqli_real_escape_string($mysqli,$_POST['trailer']);
    $tituloespanhol         = mysqli_real_escape_string($mysqli,$_POST['tituloespanhol']);
    $duracion               = mysqli_real_escape_string($mysqli,$_POST['duracion']);
    $titulooriginal	    = mysqli_real_escape_string($mysqli,$_POST['titulooriginal']);
    $idioma                 = mysqli_real_escape_string($mysqli,$_POST['idioma']);
    $tiposonido	            = mysqli_real_escape_string($mysqli,$_POST['tiposonido']);
    $distribuidora          = mysqli_real_escape_string($mysqli,$_POST['distribuidora']);
    $tipovideo	            = mysqli_real_escape_string($mysqli,$_POST['tipovideo']);
    $calificacionedad       = mysqli_real_escape_string($mysqli,$_POST['calificacionedad']);
    $relacionaspecto	    = mysqli_real_escape_string($mysqli,$_POST['relacionaspecto']);
    $numeroexp	            = mysqli_real_escape_string($mysqli,$_POST['numeroexp']);
    $fechainiciocalif       = mysqli_real_escape_string($mysqli,$_POST['fechainiciocalif']);
    $fechafincalif          = mysqli_real_escape_string($mysqli,$_POST['fechafincalif']);
    $anho	            = mysqli_real_escape_string($mysqli,$_POST['anho']);
    $arrayPaises            = $_POST['arrayPaises'];
    $arrayReparto           = $_POST['arrayReparto'];
    
    //Artículo
    $query= "INSERT INTO `articulo`(`nombre`, `descripcion`, `preciooffline`, `precioonline`, `disponibleonline`, `disponibleoffline`, `imagen`) VALUES ".
            "('$tituloespanhol ({$anho})','Película',0,0,0,0,'')";
    $mysqli->query($query);
    $idarticulo=$mysqli->insert_id;
    //Producto
    $query="INSERT INTO `producto`(`idarticulo`) VALUES ($idarticulo)";
    $mysqli->query($query);
    $idproducto=$mysqli->insert_id;
    //Vídeo
    $query= "INSERT INTO `video`(`idproducto`, `trailer`, `tituloespanhol`, `duracion`, `titulooriginal`, `idioma`, `tiposonido`, `distribuidora`, `tipovideo`, `calificacionedad`, `relacionaspecto`, `numeroexp`, `fechainiciocalif`, `fechafincalif`, `anho`) VALUES ".
    "($idproducto,'$trailer','$tituloespanhol',$duracion,'$titulooriginal','$idioma','$tiposonido','$distribuidora','$tipovideo','$calificacionedad','$relacionaspecto',$numeroexp,'$fechainiciocalif','$fechafincalif','$anho')";
    $mysqli->query($query);
    //Países
    $queryPaises = [];
    foreach ($arrayPaises as $pais) {
        $paisString = mysqli_real_escape_string($mysqli,$pais);
        array_push($queryPaises,"($idproducto,'$paisString')");
    }
    $query= "INSERT INTO `videopais`(`idproducto`, `idpais`) VALUES ".implode(',',$queryPaises);
    if(count($arrayPaises) > 0) $mysqli->query($query);
    
    //Reparto
    $queryReparto = [];
    $queryArtistas = [];
    foreach ($arrayReparto as $reparto) {
        //Rellenamos artista
        $artistaString = mysqli_real_escape_string($mysqli,$reparto[0]).",'".mysqli_real_escape_string($mysqli,$reparto[2])."'"; //imdbID y Nombre
        array_push($queryArtistas,"($artistaString)");
        
        $repartoString = $idproducto.",".$reparto[0].",".$reparto[1];
        array_push($queryReparto,"($repartoString)");
    }
    $query= "INSERT INTO `artista`(`idartista`, `nombre`) VALUES ".implode(',',$queryArtistas);
    if(count($queryArtistas) > 0) $mysqli->query($query);
    $query= "INSERT INTO `reparto`(`idproducto`, `idartista`, `idrol`) VALUES ".implode(',',$queryReparto);
    if(count($queryReparto) > 0) $mysqli->query($query);
?>