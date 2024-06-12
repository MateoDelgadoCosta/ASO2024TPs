#!/bin/bash

echo "Elige una ciudad para consultar el clima:"
echo "1. Londres"
echo "2. Buenos Aires"
echo "3. Tokio"
echo "4. Madrid"

read -p "Ingresa el numero correspondiente a la ciudad: " choice

case $choice in
  1)
    city="London"
    ;;
  2)
    city="Buenos Aires"
    ;;
  3)
    city="Tokyo"
    ;;
  4)
    city="Madrid"
    ;;
  *)
    echo "Opcion no valida."
    exit 1
    ;;
esac

api="http://api.weatherapi.com/v1/current.json?key=74eaf0f05faa4bf69db190215241106&q=$city&lang=es"

response=$(curl -s $api)

ciudad=$(echo $response | jq -r '.location.name')
temperatura=$(echo $response | jq -r '.current.temp_c')
condicion=$(echo $response | jq -r '.current.condition.text')
humedad=$(echo $response | jq -r '.current.humidity')
viento=$(echo $response | jq -r '.current.wind_kph')

echo "Clima en $ciudad:"
echo "Temperatura: $temperatura °C"
echo "Condición: $condicion"
echo "Humedad: $humedad %"
echo "Viento: $viento kph"
