CREATE DATABASE QuimicLab;
USE QuimicLab;

Create table Muestras(
ID_muestras INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(15),
clientes int,
clientes references Clientes(ID_clientes)
);

Create table Tecnico_quimicos(
ID_Tecnico_quimicos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(15),
apellido VARCHAR(15),
DNI INT(8),
especialidad VARCHAR (20),
edad INT (2)
);

Create table Analisis(
IDAnalisis INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
tecnico_quimicos INT,
muestras INT,
Compuestos_quimicos TEXT,
fechaAnalisis VARCHAR(30),
resultados VARCHAR(50),
muestras references Muestras(ID_muestras),
tecnico_quimicos references Tecnico_quimicos(ID_Tecnico_quimicos)
);

Create table Reportes(
ID_Reportes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
analisis INT,
tecnico_quimicos INT,
comportamiento TEXT,
contaminantes TEXT,
ambiente TEXT,
analisis references Analisis(IDAnalisis),
tecnico_quimicos references Tecnico_quimicos(ID_Tecnico_quimicos)
);

Create table Clientes(
ID_Clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
reportes INT,
nombre VARCHAR (30),
reportes references Reportes(ID_Reportes)
);


Select T.nombre, C.nombre, M.nombre
From Muestra, Clientes, Tecnicos_quimicos

