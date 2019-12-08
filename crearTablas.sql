-- Creacion de schema
CREATE SCHEMA public;

-- Creacion de tablas
CREATE TABLE Usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	metodoP VARCHAR(32) NOT NULL
);


CREATE TABLE Categorias(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	parent VARCHAR(32)
);

CREATE TABLE Productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	categoria_id INT4 REFERENCES Categorias(id) NOT NULL
);


CREATE TABLE Especificaciones(
	id SERIAL PRIMARY KEY,
	producto_id SERIAL REFERENCES Productos(id),
	nombre VARCHAR(32),
	valor VARCHAR(50)
);

CREATE TABLE Subastas_activas (
	id SERIAL PRIMARY KEY,
	producto_id SERIAL REFERENCES Productos(id) NOT NULL,
	descripcion TEXT,
	especificacion_id SERIAL REFERENCES Especificaciones(id),
	precio_base FLOAT8,
	precio_reserva FLOAT8,
	precio_actual FLOAT8
);

INSERT INTO Usuarios()