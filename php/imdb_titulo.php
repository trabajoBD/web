<?php
    //  https://github.com/maddox/imdb-party/blob/master/lib/imdb_party/imdb.rb
    include_once('utils.php');
    
    $pelicula = $_POST['pelicula'];
    $salida = get_content('https://app.imdb.com/find?api=v1&timestamp=0&locale=es_ES&q=' . urlencode($pelicula));
    print($salida);
?>