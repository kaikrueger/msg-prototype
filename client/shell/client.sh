#!/bin/sh

sensor_uuid="00000000000000000000000000000000"

while true; do

  sleep 1
  timestamp=$(date +%s)
  ./client
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=100" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=200" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=350" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=250" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=400" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=310" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=340" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=300" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=150" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=600" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=210" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=300" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=900" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=500" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=100" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=150" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=200" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=210" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=300" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=590" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=210" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=260" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=310" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=370" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=410" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=600" "http://localhost:3000/measurements.json"

  sleep 1
  timestamp=$(date +%s)
  curl -v -X POST -H "Accept: application/json" -d "sensor_uuid=$sensor_uuid&timestamp=$timestamp&value=800" "http://localhost:3000/measurements.json"
done
