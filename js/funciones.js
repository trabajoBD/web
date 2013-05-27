buscar_mb = function() {
    var artista = $('#formBusqueda input[name=artista]').val();
    var album = $('#formBusqueda input[name=album]').val();
    if ((artista + album).length === 0) {
            $('<p><div class="alert alert-error">\
                <a class="close" data-dismiss="alert" href="#">×</a>Introduzca datos de búsqueda\
            </div></p>')
                .hide()
                .appendTo('#formBusqueda')
                .show('slow')
                .fadeOut(2000);
    }
    else {
        $.post('./php/musicbrainz.php')
    }
}