-- Creacion de schema
CREATE SCHEMA public;

-- Creacion de tablas
CREATE TABLE Usuarios (
	id CHAR(8) PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	metodoP VARCHAR(32) NOT NULL
);


CREATE TABLE Categorias(
	id INT4 PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	parent VARCHAR(32)
);

CREATE TABLE Productos(
	id INT4 PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	categoria INT4 REFERENCES Categorias(id) NOT NULL
);


CREATE TABLE Especificaciones(
	id INT4 PRIMARY KEY,
	producto_id INT4 REFERENCES Productos(id),
	nombre VARCHAR(32),
	valor VARCHAR(50)
);

CREATE TABLE Subastas_activas (
	id INT4 PRIMARY KEY,
	nombre INT4 REFERENCES Productos(id) NOT NULL,
	descripcion TEXT,
	especificacion INT4 REFERENCES Especificaciones(id),
	precio_base FLOAT8,
	precio_reserva FLOAT8,
	precio_actual FLOAT8
);
