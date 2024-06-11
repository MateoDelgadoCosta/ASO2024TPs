#! /bin/bash
echo API de ejemplo: http://api.weatherapi.com/v1/current.json?key=74eaf0f05faa4bf69db190215241106&q=BuenosAires&aqi=yes

read -p "Ingresa la URL de la API: " api
response=$(curl -s $api)

city=$(echo $response | jq -r '.location.name')
temperature=$(echo $response | jq -r '.current.temp_c')
condition=$(echo $response | jq -r '.current.condition.text')
humidity=$(echo $response | jq -r '.current.humidity')
wind=$(echo $response | jq -r '.current.wind_kph')

echo "Clima en $city:"
echo "Temperatura: $temperature °C"
echo "Condición: $condition"
echo "Humedad: $humidity %"
echo "Viento: $wind kph"