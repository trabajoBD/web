<?php
    //Busca en MusicBrainz por FreeDB
    //Parámetros POST:
    //artista: Artista
    //album: Álbum
    if (isset($_POST['artista'])) {
        $artista = $_POST['artista'];
    }
    if (isset($_POST['album'])) {
        $album = $_POST['album'];
    }
    include('salidaejemplo.xml');
?>