#!/bin/bash

# Creando la base de datos
createdb 1310575-1211499

# Corre el script que crea las tablas necesarias para los queries
psql 1310575-1211499 -f "crearTablas.sql"