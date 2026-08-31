CREATE DATABASE QuimicLab;
USE QuimicLab;

CREATE TABLE Tecnico_quimicos(
ID_Tecnico_quimicos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(15),
apellido VARCHAR(15),
DNI INT,
especialidad VARCHAR(20),
edad INT
);

CREATE TABLE Clientes(
ID_Clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30)
);

CREATE TABLE Muestras(
ID_muestras INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(15),
clientes INT,
FOREIGN KEY (clientes) REFERENCES Clientes(ID_Clientes)
);

CREATE TABLE Analisis(
IDAnalisis INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
tecnico_quimicos INT,
muestras INT,
Compuestos_quimicos VARCHAR(100),
tipoAnalisis VARCHAR(30),
fechaAnalisis VARCHAR(30),
resultados INT,
FOREIGN KEY (muestras) REFERENCES Muestras(ID_muestras),
FOREIGN KEY (tecnico_quimicos) REFERENCES Tecnico_quimicos(ID_Tecnico_quimicos)
);

CREATE TABLE Reportes(
ID_Reportes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
analisis INT,
tecnico_quimicos INT,
comportamiento TEXT,
contaminantes TEXT,
ambiente TEXT,
FOREIGN KEY (analisis) REFERENCES Analisis(IDAnalisis),
FOREIGN KEY (tecnico_quimicos) REFERENCES Tecnico_quimicos(ID_Tecnico_quimicos)
);

INSERT INTO Tecnico_quimicos(nombre, apellido, DNI, especialidad, edad)
VALUES
('Juan', 'Perez', 40123456, 'Quimica', 25),
('Maria', 'Gomez', 42123456, 'Biologia', 30),
('Pedro', 'Lopez', 39123456, 'Analisis', 28),
('Ana', 'Rodriguez', 43123456, 'Quimica', 35);

INSERT INTO Clientes(nombre)
VALUES
('QuimicaSur'),
('BioLab'),
('Industrias Alfa'),
('Petroquimica SA');

INSERT INTO Muestras(nombre, clientes)
VALUES
('Agua', 1),
('Suelo', 2),
('Aceite', 3),
('Aire', 4),
('Agua', 1),
('Suelo', 2);

INSERT INTO Analisis(tecnico_quimicos, muestras, Compuestos_quimicos, tipoAnalisis, fechaAnalisis, resultados)
VALUES
(1, 1, 'Plomo', 'Agua', '10/08/2026', 80),
(2, 2, 'Mercurio', 'Suelo', '11/08/2026', 60),
(3, 3, 'Plomo', 'Aceite', '12/08/2026', 90),
(4, 4, 'Plomo', 'Aire', '13/08/2026', 70),
(1, 5, 'Mercurio', 'Agua', '14/08/2026', 50),
(2, 6, 'Plomo', 'Suelo', '15/08/2026', 100);

INSERT INTO Reportes(analisis, tecnico_quimicos, comportamiento, contaminantes, ambiente)
VALUES
(1, 1, 'Normal', 'Plomo', 'Agua'),
(2, 2, 'Estable', 'Mercurio', 'Suelo'),
(3, 3, 'Elevado', 'Plomo', 'Aceite'),
(4, 4, 'Normal', 'Plomo', 'Aire'),
(5, 1, 'Estable', 'Mercurio', 'Agua'),
(6, 2, 'Elevado', 'Plomo', 'Suelo');

SELECT
M.nombre AS Muestra,
C.nombre AS Empresa,
T.nombre AS Tecnico,
T.apellido AS Apellido
FROM Muestras M
INNER JOIN Clientes C
ON M.clientes = C.ID_Clientes
INNER JOIN Analisis A
ON M.ID_muestras = A.muestras
INNER JOIN Tecnico_quimicos T
ON A.tecnico_quimicos = T.ID_Tecnico_quimicos;

SELECT *
FROM Analisis
WHERE resultados > (
SELECT AVG(resultados)
FROM Analisis
);

SELECT
tipoAnalisis,
AVG(resultados) AS Promedio
FROM Analisis
GROUP BY tipoAnalisis;

SELECT
T.nombre,
T.apellido,
COUNT(A.muestras) AS Cantidad_Muestras
FROM Tecnico_quimicos T
LEFT JOIN Analisis A
ON T.ID_Tecnico_quimicos = A.tecnico_quimicos
GROUP BY T.ID_Tecnico_quimicos, T.nombre, T.apellido;

SELECT
Compuestos_quimicos,
COUNT(*) AS Cantidad
FROM Analisis
GROUP BY Compuestos_quimicos
ORDER BY Cantidad DESC
LIMIT 2;
