#!/bin/bash

if [ ! -f "$1" ] || [ ! "$2" ]; then
    echo "Usage: $0 <tracking numbers file> <email>" >&2
    exit 1
fi

while read valor; do
    ultimo_codigo=$codigo
    codigo=`echo $valor | cut -d\# -f1`
    comentario=`echo $valor | cut -d\# -f2`
    codigos="$codigos $codigo"
    # Si no tiene el comentario se muestra el número de tracking
    if [ ! "$comentario" ]; then
        comentario=$codigo
    fi 
    comentarios="$comentarios $comentario"
done < $1
accion="LocalizaVarios"
echo $codigos
    curl -k -s --data "numeros=$codigos&ecorreo=$2&accion=$accion" "https://aplicacionesweb.correos.es/localizadorenvios/track.asp" #> /dev/null

echo "Solicitud enviada para:"

for comentario in $comentarios;do 
    echo $comentario
done

