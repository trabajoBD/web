<?php
    function get_content($URL){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_URL, $URL);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept-Language: es-es'));
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    };
    function iif($tst,$cmp,$bad) {
        return(($tst == $cmp)?$cmp:$bad);
    };
?>