buscar_mb = function() {
    var artista = $('#formBusqueda input[name=artista]').val();
    var album = $('#formBusqueda input[name=album]').val();
    if ((artista + album).length === 0) {
            $('<p><div class="alert alert-error">\
                <a class="close" data-dismiss="alert" href="#">&times;</a><strong>Error:</strong> Introduzca datos de búsqueda\
            </div></p>')
                .hide()
                .appendTo('#formBusqueda')
                .show('slow')
                .fadeOut(2000);
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
                    .appendTo('#formBusqueda')
                    .show('slow')
                    .fadeOut(2000);
            }
            else {
                //Hay resultados
                var str1='<p><table id="tablaBusquedaRes" class="table table-striped">\
                        <thead><tr><th>ID</th><th>Artista</th><th>Álbum</th><th>Categoría</th><th>Año</th><th>Pistas</th></tr></thead>\
                        <tbody>';
                $.each(results,function(index,result) {
                    str1+='<tr>'+
                        '<td>'+$(result).attr('id')+'</td>'+
                        '<td>'+$(result).find('artist').text()+'</td>'+
                        '<td>'+$(result).find('title').text()+'</td>'+
                        '<td>'+$(result).find('category').text()+'</td>'+
                        '<td>'+$(result).find('year').text()+'</td>'+
                        '<td>'+$(result).find('track-list').attr('count')+'</td></tr>';
                });
                str1+='</tbody></table>';
                $(str1).appendTo('#formBusqueda');
            }
        },'xml');
    }
}