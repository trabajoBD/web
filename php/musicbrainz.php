<?php
    //Busca en MusicBrainz por FreeDB
    //Par�metros POST:
    //artista: Artista
    //album: �lbum
    if (isset($_POST['artista'])) {
        $artista = $_POST['artista'];
    }
    if (isset($_POST['album'])) {
        $album = $_POST['album'];
    }
    include('salidaejemplo.xml');
?>