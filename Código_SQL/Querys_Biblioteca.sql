USE Biblioteca;

-- 1. Libros deteriorados y no encontrados 
SELECT ID_Libro, titulo, Estado 
FROM Libro 
WHERE Estado IN ('Deteriorado', 'No encontrado');

-- 2. Libros actualmente prestados / no devueltos 
SELECT 
    L.ID_Libro, 
    L.titulo, 
    S.Nombre AS Socio_Prestatario, 
    P.Fecha_Prestamo     
FROM Libro L
JOIN Prestamo_Libro PL ON L.ID_Libro = PL.ID_Libro 
JOIN Prestamo P ON PL.ID_Prestamo = P.ID_Prestamo 
JOIN Socio S ON P.ID_Socio = S.ID_Socio 
WHERE P.Fecha_Devolución IS NULL;

-- 3. Socios que deben cuotas societarias 
SELECT ID_Socio, Nombre, Cuota 
FROM Socio 
WHERE Cuota = 'Debe';

-- 4. Socios que tienen libros prestados actualmente 
SELECT DISTINCT 
    S.ID_Socio, 
    S.Nombre, 
    S.Cuota, 
    P.Fecha_Prestamo 
FROM Socio S 
JOIN Prestamo P ON S.ID_Socio = P.ID_Socio 
WHERE P.Fecha_Devolución IS NULL;

-- 5. Búsqueda/Catálogo completo de libros 
SELECT
    L.ID_Libro,
    L.titulo,
    E.Nombre_Editorial,
    T.Nombre_Tema,
    A.NyA AS Autor
FROM Libro L
JOIN Editorial E ON L.ID_Editorial = E.ID_Editorial
JOIN Tema T ON L.ID_Tema = T.ID_Tema
JOIN Libro_Autor LA ON L.ID_Libro = LA.ID_Libro
JOIN Autor A ON LA.ID_Autor = A.ID_Autor 
ORDER BY ID_Libro ASC;

-- 6. Total de libros en el catálogo y libros prestados actualmente
SELECT 
    (SELECT COUNT(*) FROM Libro) AS Total_Catalogo,
    (SELECT COUNT(DISTINCT PL.ID_Libro) 
     FROM Prestamo_Libro PL 
     JOIN Prestamo P ON PL.ID_Prestamo = P.ID_Prestamo 
     WHERE P.Fecha_Devolución IS NULL) AS Total_Prestados;