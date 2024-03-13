CREATE DATABASE IF NOT EXISTS cabfly;

USE cabfly;

CREATE TABLE PASAJERO (
    id_pasajero INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    documento VARCHAR(20),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE RESERVA (
    id_reserva INT PRIMARY KEY,
    id_pasajero INT,
    fecha_creacion DATE,
    costo DECIMAL(10, 2),
    vigencia DATETIME,
    FOREIGN KEY (id_pasajero) REFERENCES PASAJERO(id_pasajero)
);

CREATE TABLE VUELO (
    id_vuelo INT PRIMARY KEY,
    origen VARCHAR(100),
    destino VARCHAR(100),
    fecha_salida DATE,
    hora_salida TIME,
    puerta_embarque VARCHAR(20)
);

CREATE TABLE ASIENTO (
    id_asiento INT PRIMARY KEY,
    id_vuelo INT,
    numero_asiento VARCHAR(10),
    tipo_asiento VARCHAR(20),
    costo_extra DECIMAL(10, 2),
    ocupado BOOLEAN,
    FOREIGN KEY (id_vuelo) REFERENCES VUELO(id_vuelo)
);

CREATE TABLE TARJETA_DE_EMBARQUE (
    id_tarjeta INT PRIMARY KEY,
    id_reserva INT,
    id_asiento INT,
    fecha_emision DATETIME,
    puerta_embarque VARCHAR(20),
    hora_embarque TIME,
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva),
    FOREIGN KEY (id_asiento) REFERENCES ASIENTO(id_asiento)
);

CREATE TABLE METODO_DE_PAGO (
    id_pago INT PRIMARY KEY,
    id_reserva INT,
    metodo VARCHAR(50),
    monto_pagado DECIMAL(10, 2),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva)
);
