<?php
    $mysqli = new mysqli("localhost", "frasolmun", "OdsLxOdR7CJGu2z7hy4p", "frasolmun");
    $mysqli->set_charset("utf8");
    $pelicula = mysqli_real_escape_string($mysqli,$_POST['pelicula']);
    $query = "SELECT * FROM `calificacion` WHERE titulocomercial LIKE '".$pelicula."' OR titulooriginal LIKE '".$pelicula."' ORDER BY expediente DESC LIMIT 9";
    $res=$mysqli->query($query);
    $result=[];
    while ($fila = $res->fetch_assoc()) {
        array_walk($fila,create_function('&$val', '$val = trim($val);')); 
        array_push($result,$fila);
    }
    print(json_encode($result));
?>