jQuery.fn.reset = function () {
  $(this).each(function() { this.reset(); });
  $(this).find('.reseteable:not(:first-of-type)').remove();
};

function secondsToTime(secs,fmt)
{
    // http://stackoverflow.com/questions/3733227/javascript-seconds-to-minutes-and-seconds
    var date = new Date(null);
    date.setSeconds(secs);
    var time = date.toTimeString().split(" ")[0];
    if (fmt==0) time = time.substring(3,8);
    return(time);
}

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
                var str1='<table id="resultadosBusquedaCD" class="table table-bordered table-striped table-condensed">\
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
                        <input name="pistaTitulo" class="span4" type="text" placeholder="Título">\
                        <div class="input-append">\
                          <input name="pistaDuracion" type="text"  placeholder="Duración"><span class="add-on">seg.</span>\
                        </div>\
                    </div>').insertBefore('#anhadirPista');
            $('div.reseteable:last-of-type input[name=pistaArtista]').val($(fila).find('td.artistaAlbum').text());
            $('div.reseteable:last-of-type input[name=pistaTitulo]').val(track);
            $('div.reseteable:last-of-type input[name=pistaDuracion]').val(Math.round(data.longitudes[i]));
        });
        
        $.scrollTo($('#formIntrod').parent(),800);
    },'json');
};


enviarDisco = function() {
    var datosEnvio = new Object;
    datosEnvio['artista'] = $('#datosgen input[name=artista]').val();
    datosEnvio['album'] = $('#datosgen input[name=album]').val();
    datosEnvio['anho'] = $('#datosgen input[name=anho]').val();
    datosEnvio['duracion'] = $('#datosgen input[name=duracion]').val();
    datosEnvio['genero'] = $('#datosgen input[name=genero]').val();
    datosEnvio['arrayTracks'] = [];
    $('#pistas div.controls').each( function(index,obj) {
        datosEnvio['arrayTracks'].push([index,
                                        $(obj).find('input[name=pistaArtista]').val(),
                                        $(obj).find('input[name=pistaTitulo]').val(),
                                        $(obj).find('div input[name=pistaDuracion]').val()]
                                       );
    });
    $('#guardarCambios').attr("disabled", true);
    $.post('./php/insertarDisco.php',datosEnvio,function(data) {
        $('#guardarCambios').attr("disabled", false);
    });
}

$(function() {
    $('#anhadirPista').click(function () {
        $('<div class="controls well reseteable">\
                      <span class="control-label numeroTrack span1">Pista ' + ($('.numeroTrack').size()+1).toString() + '</span>\
                      <input name="pistaArtista" class="span4" type="text" placeholder="Artista">\
                      <input name="pistaTitulo" class="span4" type="text" placeholder="Título">\
                      <div class="input-append">\
                        <input name="pistaDuracion" type="text"  placeholder="Duración"><span class="add-on">seg.</span>\
                      </div>\
                    </div>').insertBefore('#anhadirPista');
    });
    $('#quitarPista').click(function() {
        if ($('.numeroTrack').size() > 1) $('.numeroTrack').last().parent().remove();
    })
    $('#resetearFormulario').click(function() {
        $('#formIntrod').reset()
    });
    $('#guardarCambios').click(enviarDisco);
    $('#ultimosCds').each(function() {
        $.get('./php/ultimosDiscos.php',function(data) {
            obj = $.parseJSON(data);
            $(obj).each(function(index,objact) {
                $('#ultimosCds').append($('\
                    <div class="span3 cd well">\
                        <h2 class="text-info nombreDisco">The Number of the Beast</h2>\
                        <h3 class="text-info grupoDisco">Iron Maiden</h3>\
                        <span class="label label-info generoDisco">Rock</span>\
                        <h5 class="anhoDisco">1982</h5>\
                        <h5 class="duracionDisco">1h 36m</h5>\
                        \
                        <table class="table table-bordered table-striped table-condensed">\
                            <thead><tr><th>#</th><th>Artista</th><th>Título</th><th>Duración</th></tr></thead>\
                            <tbody>\
                            </tbody>\
                        </table>\
                    </div>'));
                $('#ultimosCds div.cd:last-of-type h2.nombreDisco').html(objact.album);
                $('#ultimosCds div.cd:last-of-type h3.grupoDisco').html(objact.artista);
                $('#ultimosCds div.cd:last-of-type span.generoDisco').html(objact.genero);
                $('#ultimosCds div.cd:last-of-type h5.anhoDisco').html(objact.anho);
                $('#ultimosCds div.cd:last-of-type h5.duracionDisco').html(secondsToTime(objact.duracion,1));
                $(objact.datostracks).each(function(index2,objact2) {
                    $('#ultimosCds div.cd:last-of-type').find('tbody').append($('<tr><td>' + objact2.numero +'</td><td>'+ objact2.artista +'</td><td>'+ objact2.titulo +'</td><td>'+ secondsToTime(objact2.duracion,0)+'</td></tr>'));
                });
            });
        });
    });
    $('#b_buscaMCU').click(function() {
        var buscar = $(this).parent().find('input[name=pelicula]').val();
        if (buscar.length === 0) {
             $('<p><div class="alert alert-error">\
            <a class="close" data-dismiss="alert" href="#">&times;</a><strong>Error:</strong> Introduzca datos de búsqueda\
            </div></p>')
                .hide()
                .insertAfter('#formBusquedaPeli')
                .show('slow')
                .fadeOut(2000, function() { $(this).remove(); });
        }
        else {
            $.post('./php/mcu.php',"pelicula="+buscar,function(data){
                if (data.length === 0) {
                    //No hay resultados
                    $('<p><div class="alert">\
                    <a class="close" data-dismiss="alert" href="#">&times;</a>No hay resultados\
                    </div></p>')
                        .hide()
                        .insertAfter('#formBusquedaPeli')
                        .show('slow')
                        .fadeOut(2000, function() { $(this).remove(); });
                }
                else {
                    //Hay resultados
                    $('#pestanhaMCU').remove();
                    var str1='<div id="pestanhaMCU"><div class="cabeceraMCU"><span>Resultados MCU</span></div><table id="resultadosBusquedaMCU" class="table table-bordered table-striped table-condensed">\
                            <thead><tr><th>Expediente</th><th>Título orig.</th><th>Título com.</th><th>Distribuidora</th><th>Calificación</th><th>Fecha calif. 1</th><th>Fecha calif. 2</th></tr></thead>\
                            <tbody>';
                    $.each(data,function(index,result) {
                        str1+='<tr>'+
                            '<td class="expediente">'+result['expediente']+'</td>'+
                            '<td class="titOrig">'+result['titulooriginal']+'</td>'+
                            '<td class="titCom">'+result['titulocomercial']+'</td>'+
                            '<td class="distr">'+(result['distribuidora']!=null ? result['distribuidora'] : '')+'</td>'+
                            '<td class="calif">'+(result['calificacion']!=null ? result['calificacion'] : '')+'</td>'+
                            '<td class="fcalif1">'+result['fechacal1']+'</td>'+
                            '<td class="fcalif2">'+(result['fechacal2']!='0000-00-00' ? result['fechacal2'] : '')+'</td></tr>';
                    });
                    str1+='</tbody></table></div></div>';
                    $(str1).insertAfter('#formBusquedaPeli');
                    $('div.cabeceraMCU').click(function() {
                        $('#resultadosBusquedaMCU').slideToggle("slow");
                    });
                    $('#resultadosBusquedaMCU tbody tr').each(function(index,object) {
                        $(object).click(function() {
                            var numexp = $(this).find('td.expediente').text();
                            var fcalif1 = $(this).find('td.fcalif1').text();
                            var fcalif2 = $(this).find('td.fcalif2').text();
                            var calif = $(this).find('td.calif').text();
                            
                            try { $('#formAgregarPeli input[name=numeroexp]').val(numexp);                     } catch(e) { };
                            try { $('#formAgregarPeli input[name=fechainiciocalif]').val(fcalif1);             } catch(e) { };
                            try { $('#formAgregarPeli input[name=fechafincalif]').val(fcalif2);                } catch(e) { };
                            try { $('#formAgregarPeli input[name=clasificacionedad]').val(calif);              } catch(e) { };
                            
                            
                            $('#resultadosBusquedaMCU').slideToggle("slow");
                        });
                    });
                }   
        },'json');
        }
    });
    $('#b_buscaIMDB').click(function() {
        var buscar = $(this).parent().find('input[name=pelicula]').val();
        if (buscar.length === 0) {
             $('<p><div class="alert alert-error">\
            <a class="close" data-dismiss="alert" href="#">&times;</a><strong>Error:</strong> Introduzca datos de búsqueda\
            </div></p>')
                .hide()
                .insertAfter('#formBusquedaPeli')
                .show('slow')
                .fadeOut(2000, function() { $(this).remove(); });
        }
        else {
            $.post('./php/imdb_titulo.php',"pelicula="+buscar,function(data){
                if (data.data.results.length === 0) {
                    //No hay resultados
                    $('<p><div class="alert">\
                    <a class="close" data-dismiss="alert" href="#">&times;</a>No hay resultados\
                    </div></p>')
                        .hide()
                        .insertAfter('#formBusquedaPeli')
                        .show('slow')
                        .fadeOut(2000, function() { $(this).remove(); });
                }
                else {
                    //Hay resultados
                    $('#pestanhaIMDB').remove();
                    var str1='<div id="pestanhaIMDB"><div class="cabeceraIMDB"><span>Resultados IMDB</span></div><table id="resultadosBusquedaIMDB" class="table table-bordered table-striped table-condensed">\
                            <thead><tr><th>ID</th><th>Nombre</th><th>Año</th></tr></thead>\
                            <tbody>';
                    $.each(data.data.results[0].list,function(indexcat,result){
                        if (result.type == "feature" || result.type == "video") {
                            str1+='<tr>'+
                                '<td class="id">'+result['tconst']+'</td>'+
                                '<td class="nombre">'+result['title']+'</td>'+
                                '<td class="anho">'+result['year']+'</td>'; 
                        }
                    })
                    
                    str1+='</tbody></table></div></div>';
                    $(str1).insertAfter('#formBusquedaPeli');
                    $('div.cabeceraIMDB').click(function() {
                        $('#resultadosBusquedaIMDB').slideToggle("slow");
                    });
                    $('#resultadosBusquedaIMDB tbody tr').each(function(index,object) {
                        $(object).click(function() {
                            $.post('./php/imdb_tt.php',"tt="+$(this).find('td.id').text(),function(data){
                                var titulo=$('#overview-top h1.header span.itemprop[itemprop=name]',data).text();  //Título
                                var tituloorig=$('#overview-top h1.header span.title-extra[itemprop=name]',data).text();  //Título Original
                                var anho=$('#overview-top h1.header span.nobr a[href*=year]',data).text();       //Año
                                var trama=$('#overview-top p[itemprop=description]',data).text();          //Trama
                                //Países: id, nombre para mostrar
                                var paises=[];
                                $('#titleDetails a[href*=country]', data).each(function(index,obj){ paises.push([$(obj).attr('href').split('/')[2].split('?')[0],$(obj).html()]) });
                                var duracion=$($('#titleDetails time[itemprop=duration]',data)[0]).text();
                                var relaspecto=$('h4:contains("Aspect Ratio")',data);                    
                                
                                
                                //Agregamos al formulario
                                try { $('#formAgregarPeli input[name=tituloespanhol]').val(titulo.trim())                                                                } catch(e){}
                                try { $('#formAgregarPeli input[name=titulooriginal]').val(tituloorig.split('"')[1].trim())                                              } catch(e){}
                                try { $('#formAgregarPeli input[name=anho]').val(anho.trim())                                                                            } catch(e){}
                                try { $('#formAgregarPeli input[name=duracion]').val(duracion.split(' ')[0].trim())                                                      } catch(e){}
                                try { $('#formAgregarPeli input[name=relacionaspecto]').val(relaspecto.parent().text().trim().replace("Aspect Ratio: ",""))                   } catch(e){}
                                
                                $('#resultadosBusquedaIMDB').slideToggle("slow");
                            });
                        });
                    });
                }   
        },'json');
        }
    });
    $.fn.editable.defaults.mode = 'inline';
    paises = [];
    $('#paisespeli').ready(function() {
        $.get("./php/paises.php",function(data) {
            paises = data;
            $('td.selectpais .editable').editable({
                value: 1,
                source: paises,
                showbuttons: false
            });
            $('#anhadefilapais').click(function() {
                var str1 = '<tr>\
                    <td class="selectpais">\
                        <a href="#" data-type="select" data-pk="1" data-value="af" data-original-title="Selecciona país" class="editable editable-click" style="display: inline;">Afghanistan</a>\
                    </td>\
                </tr>';
                $(str1).insertAfter('#paisespeli tbody tr:last-of-type');
                $('#paisespeli tbody tr:last-of-type a').editable({
                    value: "af",
                    source: paises,
                    showbuttons: false
                });
            });
            $('#quitafilapais').click(function() {
                $('#paisespeli tbody tr:last-of-type').remove();
            });
        },"json");
    })
    
});
