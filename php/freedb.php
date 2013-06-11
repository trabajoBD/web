<?php

    include_once('utils.php');
    
    function my_parse_ini_string($string) {
        $flagOffset = FALSE;
        $offsets = [];
        $res['discolength'] = 0;
        $res['tracks'] = [];
        $res['dtitle'] = '';
        $res['discid'] = '';
        $res['dyear'] = '';
        $res['dgenre'] = '';
        $lastSong = -1;
        $res['longitudes'] = [];
        define("TFPS",75);
        
        foreach(preg_split("/((\r?\n)|(\r\n?))/", $string) as $line){
            if ($flagOffset === TRUE) {
                if ( strncmp($line,"#",2) == 0 ) {
                    $flagOffset = FALSE;
                }
                else 
                    array_push($offsets,intval(trim(str_replace('#','',$line))));
            }
            else {
                if (strncmp($line,"#",1) == 0) {
                    if ( strncmp("# Track frame offsets:",$line,22) == 0 ) {
                        $flagOffset = TRUE;
                    }
                    elseif ( strncmp("# Disc length:",$line,14) == 0 ) {
                        $res['discolength'] = intval(str_replace(" seconds",'',trim(str_replace("# Disc length:",'',$line))));
                    }
                }
                else {
                    $arrlinea=preg_split('/=/',$line);
                    if (strncmp($arrlinea[0],"DISCID",6)==0) $res['discid'] = str_replace("DISCID=","",$line);
                    elseif (strncmp($arrlinea[0],"DTITLE",6)==0) $res['dtitle'] = str_replace("DTITLE=","",$line);
                    elseif (strncmp($arrlinea[0],"DYEAR",5)==0) $res['dyear'] = intval(str_replace("DYEAR=","",$line));
                    elseif (strncmp($arrlinea[0],"DGENRE",6)==0) $res['dgenre'] = str_replace("DGENRE=","",$line);
                    elseif (strncmp($arrlinea[0],"TTITLE",6)==0) {
                        $songTrack = intval(str_replace("TTITLE","",$arrlinea[0]));
                        if ($songTrack == $lastSong) {
                            $res['tracks'][$lastSong] .= $arrlinea[1];
                        }
                        else array_push($res['tracks'],$arrlinea[1]);
                        $lastSong = $songTrack;
                    }
                }
            }
        }
        //Última canción
        array_push($offsets,$res['discolength'] * TFPS + TFPS);
        $startFrame = $offsets[0];
        for ($i = 1;$i<=count($offsets)-1;$i++) {
            array_push($res['longitudes'],($offsets[$i]-$startFrame)/TFPS);
            $startFrame = $offsets[$i];
        }
        return $res;
    }
   

    //Rescata datos de FreeDB
    $discoid="";
    $discocat="";
    if (isset($_POST['discoID'])) {
        $discoid = $_POST['discoID'];
    }
    if (isset($_POST['discoCat'])) {
        $discocat = $_POST['discoCat'];
    }
    
    $salidatxt = get_content('http://www.freedb.org/freedb/' . $discocat . '/' . $discoid);
    $res=my_parse_ini_string($salidatxt);
    print(json_encode($res));
?>