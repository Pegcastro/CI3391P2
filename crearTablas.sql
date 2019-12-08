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
	parent_id INT4 REFERENCES Categorias(id),
	es_hoja BOOLEAN
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
	producto_id INT4 REFERENCES Productos(id) NOT NULL,
	descripcion TEXT,
	especificacion_id INT4 REFERENCES Especificaciones(id),
	precio_base FLOAT8,
	precio_reserva FLOAT8,
	precio_actual FLOAT8
);

-- Insert de Usuarios
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Edith", "Credito");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Vivien", "Transferencia");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Daniel", "Crypto");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Laurella", "Debito");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Osbert", "Crypto");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Sebastian", "Debito");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Cleopatra", "Crédito");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Doy", "Transferencia");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Anna", "Crédito");
INSERT INTO Usuarios(nombre, metodoP)
VALUES("Diana", "Transferencia");

-- Insert de Categorias