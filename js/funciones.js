buscar_mb = function() {
    var artista = $('#formBusqueda input[name=artista]').val();
    var album = $('#formBusqueda input[name=album]').val();
    if ((artista + album).length === 0) {
            $('<p><div class="alert alert-error">\
            <a class="close" data-dismiss="alert" href="#">&times;</a><strong>Error:</strong> Introduzca datos de búsqueda\
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
                        <thead><tr><th>ID</th><th>Artista</th><th>Álbum</th><th>Categoría</th><th>Año</th><th>Pistas</th></tr></thead>\
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
}
obtenerDatos = function() {
    var discoID = $(this).find('td.idAlbum').text();
    alert(discoID);
}