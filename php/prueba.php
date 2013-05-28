<?php
    //Prueba freeDB
    function get_content($URL){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_URL, $URL);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }
    function startsWith($haystack, $needle)
    {
        return !strncmp($haystack, $needle, strlen($needle));
    }
    function endsWith($haystack, $needle)
    {
        $length = strlen($needle);
        if ($length == 0) {
            return true;
        }
    
        return (substr($haystack, -$length) === $needle);
    }
    
    function my_parse_ini_string($string) {
        $flagOffset = FALSE;
        $res['offsets'] = [];
        $res['discolength'] = 0;
        $res['tracks'] = [];
        $res['dtitle'] = '';
        $res['discid'] = '';
        $res['dyear'] = '';
        $res['dgenre'] = '';
        
        foreach(preg_split("/((\r?\n)|(\r\n?))/", $string) as $line){
            if ($flagOffset === TRUE) {
                if ( strncmp($line,"#",2) == 0 )
                    $flagOffset = FALSE;
                else 
                    array_push($res['offsets'],trim(str_replace('#','',$line)));
            }
            else {
                if (strncmp($line,"#",1) == 0) {
                    if ( strncmp("# Track frame offsets:",$line,22) == 0 ) {
                        $flagOffset = TRUE;
                    }
                    if ( strncmp("# Disc length:",$line,14) == 0 ) {
                        $res['discolength'] = str_replace(" seconds",'',trim(str_replace("# Disc length:",'',$line)));
                    }
                }
                else {
                    $arrlinea=preg_split('/=/',$line);
                    print_r($arrlinea);
                    if (strncmp($arrlinea[0],"DISCID",strlen($arrlinea[0]))==0) $res['discid'] = str_replace("DISCID=","",$line);
                    if (strncmp($arrlinea[0],"DTITLE",strlen($arrlinea[0]))==0) $res['dtitle'] = str_replace("DTITLE=","",$line);
                    if (strncmp($arrlinea[0],"DYEAR",strlen($arrlinea[0]))==0) $res['dyear'] = str_replace("DYEAR=","",$line);
                    if (strncmp($arrlinea[0],"DGENRE",strlen($arrlinea[0]))==0) $res['dgenre'] = str_replace("DGENRE=","",$line);
                }
            }
        } 
        return $res;
    }
    $salidatxt = get_content('http://www.freedb.org/freedb/rock/9b12700a');
    //Inspirado en https://github.com/peik/freedb-parser-sample/blob/master/src/tdd/musicdb/AlbumParser.java
    print_r(my_parse_ini_string($salidatxt));
?>