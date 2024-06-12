#!/bin/bash

echo "Contenido del archivo texto.txt:"
cat texto.txt
echo

lineas=$(wc -l < texto.txt)
palabras=$(wc -w < texto.txt)
caracteres=$(wc -m < texto.txt)

echo "Estadisticas del archivo texto.txt:"
echo "Numero de lineas: $lineas"
echo "Numero de palabras: $palabras"
echo "Numero de caracteres: $caracteres"
