#!/bin/bash

if [ ! -f "$1" ]; then
    echo "Usage: $0 <tracking numbers file>" >&2
    exit 1
fi

while read linea; do
    codigo=`echo $linea | cut -d\# -f1`
    comentario=`echo $valor | cut -d\# -f2`
    if [ ! "$comentario" ]; then
        comentario=$codigo
    fi    
    echo "### Pedido [ $comentario ] ###"
    curl -k -s --data "numero=$codigo&accion=LocalizaUno" "https://aplicacionesweb.correos.es/localizadorenvios/track.asp" | tail -n 4 | head -1 | LANG=es_ES.iso88591 sed 's/.*soap:Body.\(.*\)<\/soap:Body.*/\1/g' | python mailTracker.py
    echo ""
done < "$1"
