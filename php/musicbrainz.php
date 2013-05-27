<?php

    function get_content($URL){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_URL, $URL);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }
    function iif($tst,$cmp,$bad) {
        return(($tst == $cmp)?$cmp:$bad);
    }
    //Busca en MusicBrainz por FreeDB
    //Parámetros POST:
    //artista: Artista
    //album: Álbum
    $artista="";
    $album="";
    if (isset($_POST['artista'])) {
        $artista = $_POST['artista'];
    }
    if (isset($_POST['album'])) {
        $album = $_POST['album'];
    }
    
    $salida = get_content('http://search.musicbrainz.org/ws/2/freedb/?query=' . urlencode(
            iif(strlen($artista)>0,
            'artist:' . $artista . iif(strlen($album)>0,' AND title:' . $album,''),
            'title:' . $album)
        ));
    print($salida);
?>