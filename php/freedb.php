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
    $discoid="";
    $discocat="";
    if (isset($_POST['discoID'])) {
        $discoid = $_POST['discoID'];
    }
    if (isset($_POST['discoCat'])) {
        $discocat = $_POST['discoCat'];
    }
    
    $salidatxt = get_content('http://www.freedb.org/freedb/' . $discocat . '/' . $discoid);
    $salida = parse_ini_string($salidatxt);
    print(json_encode($salida));
?>