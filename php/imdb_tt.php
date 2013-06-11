<?php
    //  https://github.com/maddox/imdb-party/blob/master/lib/imdb_party/imdb.rb
    include_once('utils.php');
    
    $tt = $_POST['tt'];
    $salida = get_content('http://www.imdb.com/title/' . urlencode($tt) . '/');
    print($salida);
?>