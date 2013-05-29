jQuery.fn.reset = function () {
  $(this).each(function() { this.reset(); });
  $(this).find('.reseteable:not(:first-of-type)').remove();
};

buscar_mb = function() {
    var artista = $('#formBusqueda input[name=artista]').val();
    var album = $('#formBusqueda input[name=album]').val();
    if ((artista + album).length === 0) {
            $('<p><div class="alert alert-error">\
            <a class="close" data-dismiss="alert" href="#">&times;</a><strong>Error:</strong> Introduzca datos de b�squeda\
            </div></p>')
                .hide()
                .insertAfter('#formBusqueda')
                .show('slow')
                .fadeOut(2000, function() { $(this).remove(); });
    }
    else {
        $.post('./php/musicbrainz.php',$('#formBusqueda').serialize(),function(data){
            var results = $(data).find('freedb-disc');
            if (results.length === 0) {
                //No hay resultados
                $('<p><div class="alert">\
                <a class="close" data-dismiss="alert" href="#">&times;</a>No hay resultados\
                </div></p>')
                    .hide()
                    .insertAfter('#formBusqueda')
                    .show('slow')
                    .fadeOut(2000, function() { $(this).remove(); });
            }
            else {
                //Hay resultados
                $('#resultadosBusquedaCD').remove();
                var str1='<p><table id="resultadosBusquedaCD" class="table table-bordered table-striped table-condensed">\
                        <thead><tr><th>ID</th><th>Artista</th><th>�lbum</th><th>Categor�a</th><th>A�o</th><th>Pistas</th></tr></thead>\
                        <tbody>';
                $.each(results,function(index,result) {
                    str1+='<tr>'+
                        '<td class="idAlbum">'+$(result).attr('id')+'</td>'+
                        '<td class="artistaAlbum">'+$(result).find('artist').text()+'</td>'+
                        '<td class="tituloAlbum">'+$(result).find('title').text()+'</td>'+
                        '<td class="catAlbum">'+$(result).find('category').text()+'</td>'+
                        '<td class="anyoAlbum">'+$(result).find('year').text()+'</td>'+
                        '<td class="tracksAlbum">'+$(result).find('track-list').attr('count')+'</td></tr>';
                });
                str1+='</tbody></table>';
                $(str1).insertAfter('#formBusqueda');
                $('#resultadosBusquedaCD tr').click(obtenerDatos);
            }
        },'xml');
    }
};
obtenerDatos = function() {
    var datosEnvio = new Object;
    var fila = $(this);
    datosEnvio['discoID'] = $(this).find('td.idAlbum').text();
    datosEnvio['discoCat'] = $(this).find('td.catAlbum').text();
    $.post('./php/freedb.php',datosEnvio,function(data){
        $('#formIntrod .reseteable').remove();  //Para que se elimine el primero
        $('#formIntrod').reset();
        $('#datosgen input[name=artista]').val($(fila).find('td.artistaAlbum').text());
        $('#datosgen input[name=album]').val($(fila).find('td.tituloAlbum').text());
        $('#datosgen input[name=anho]').val(data.dyear);
        $('#datosgen input[name=duracion]').val(data.discolength);
        $('#datosgen input[name=genero]').val(data.dgenre);
        //Introducimos pistas
        $(data.tracks).each(function(i,track) {
            $('     <div class="controls well reseteable">\
                        <span class="control-label numeroTrack span1">Pista ' + (i+1).toString() + '</span>\
                        <input name="pistaArtista" class="span4" type="text" placeholder="Artista">\
                        <input name="pistaTitulo" class="span4" type="text" placeholder="T�tulo">\
                        <div class="input-append">\
                          <input name="pistaDuracion" type="text"  placeholder="Duraci�n"><span class="add-on">seg.</span>\
                        </div>\
                    </div>').insertBefore('#anhadirPista');
            $('div.reseteable:last-of-type input[name=pistaArtista]').val($(fila).find('td.artistaAlbum').text());
            $('div.reseteable:last-of-type input[name=pistaTitulo]').val(track);
            $('div.reseteable:last-of-type input[name=pistaDuracion]').val(Math.round(data.longitudes[i]));
        });
        
        $.scrollTo($('#formIntrod').parent(),800);
    },'json');
};

$(function() {
    $('#anhadirPista').click(function () {
        $('<div class="controls well reseteable">\
                      <span class="control-label numeroTrack span1">Pista ' + ($('.numeroTrack').size()+1).toString() + '</span>\
                      <input name="pistaArtista" class="span4" type="text" placeholder="Artista">\
                      <input name="pistaTitulo" class="span4" type="text" placeholder="T�tulo">\
                      <div class="input-append">\
                        <input name="pistaDuracion" type="text"  placeholder="Duraci�n"><span class="add-on">seg.</span>\
                      </div>\
                    </div>').insertBefore('#anhadirPista');
    });
    $('#quitarPista').click(function() {
        if ($('.numeroTrack').size() > 1) $('.numeroTrack').last().parent().remove();
    })
    $('#resetearFormulario').click(function() {
        $('#formIntrod').reset()
    });
});

enviarDisco = function() {
    var datosEnvio = new Object;
    datosEnvio['artista'] = $('#datosgen input[name=artista]').val();
    datosEnvio['album'] = $('#datosgen input[name=album]').val();
    datosEnvio['anho'] = $('#datosgen input[name=anho]').val();
    datosEnvio['duracion'] = $('#datosgen input[name=duracion]').val();
    datosEnvio['genero'] = $('#datosgen input[name=genero]').val();
    $('#guardarCambios').attr("disabled", true);
    $.post('./php/insertarDisco.php',datosEnvio,function(data) {
        console.log(data);
        $('#guardarCambios').attr("disabled", false);
    });
}
