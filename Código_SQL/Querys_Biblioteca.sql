USE Biblioteca;

-- 1. Libros deteriorados y no encontrados 
SELECT ID_Libro, titulo, Estado 
FROM Libro 
WHERE Estado IN ('Deteriorado', 'No encontrado');


-- 2. Socios que deben cuotas societarias 
SELECT ID_Socio, Nombre, Cuota 
FROM Socio 
WHERE Cuota = 'Debe';
