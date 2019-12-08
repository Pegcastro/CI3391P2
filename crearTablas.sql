-- Creacion de schema
CREATE SCHEMA public;

-- Elimina las tablas si han sido creadas anteriormente
DROP TABLE IF EXISTS Usuarios CASCADE; 
DROP TABLE IF EXISTS Categorias CASCADE;
DROP TABLE IF EXISTS Productos CASCADE;
DROP TABLE IF EXISTS Especificaciones CASCADE;
DROP TABLE IF EXISTS Subastas_activas CASCADE;


-- Creacion de tablas
CREATE TABLE Usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL,
	metodoP VARCHAR(32) NOT NULL
);

CREATE TABLE Categorias(
	id INT4 PRIMARY KEY,
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
	producto_id INT4 REFERENCES Productos(id),
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
VALUES('Edith', 'Credito');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Vivien', 'Transferencia');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Daniel', 'Crypto');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Laurella', 'Debito');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Osbert', 'Crypto');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Sebastian', 'Debito');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Cleopatra', 'Crédito');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Doy', 'Transferencia');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Anna', 'Crédito');
INSERT INTO Usuarios(nombre, metodoP)
VALUES('Diana', 'Transferencia');

-- Insert de Categorias
INSERT INTO Categorias(id, nombre, parent_id, es_hoja)
VALUES(0, 'Motores', NULL, FALSE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(1, 'Carros y Camionetas', 0, FALSE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(2, 'Chevrolet', 1, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(3, 'Mitsubishi', 1, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(4, 'Ford', 1, TRUE);
INSERT INTO Categorias(id, nombre, parent_id, es_hoja)
VALUES(5, 'Electronics', NULL, FALSE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(6, 'Laptops', 5, FALSE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(7, 'Asus', 6, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(8, 'HP', 6, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(9, 'Mac', 6, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(10, 'Celulares', 5, FALSE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(11, 'Motorola', 10, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(12, 'Iphone', 10, TRUE);
INSERT INTO Categorias(id, nombre, parent_id,es_hoja)
VALUES(13, 'Nokia', 10, TRUE);

-- Insert de Productos