-- TABLA: domicilio
-- insertar
INSERT INTO domicilio (fecha_ingreso, comuna_nombre_calle, numero, sector, nombre_contacto, email, celular) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
-- seleccionar ultimos 5 registros de un domicilio
SELECT id, fecha_ingreso, comuna_nombre_calle, numero, sector, nombre_contacto, email, celular FROM domicilio ORDER BY fecha_ingreso DESC LIMIT 5
-- seleccionar siguientes ultimos 5 registros de un domicilio
SELECT id, fecha_ingreso, comuna_nombre_calle, numero, sector, nombre_contacto, email, celular FROM domicilio ORDER BY fecha_ingreso DESC LIMIT 5 OFFSET 5

-- TABLA: mascota_domicilio
-- insertar
INSERT INTO mascota_domicilio (tipo_mascota_edad, color, raza, esterilizado, vacunas_al_dia, domicilio_id) VALUES (?, ?, ?, ?, ?, ?, ?);
-- seleccionar mascotas de un domicilio
SELECT id, tipo_mascota_edad, color, raza, esterilizado, vacunas_al_dia, domicilio_id FROM mascota_domicilio WHERE domicilio_id=? ORDER BY id ASC

-- TABLA: foto_mascota
-- insertar
INSERT INTO foto_mascota (ruta_archivo, nombre_archivo, mascota_domicilio_id) VALUES (?, ?, ?);
-- seleccionar fotos de una mascota
SELECT id, ruta_archivo, nombre_archivo, mascota_domicilio_id FROM foto_mascota WHERE mascota_domicilio_id = ? ORDER BY id ASC

-- TABLA: tipo_mascota
-- insertar
INSERT INTO tipo_mascota (nombre) VALUES (?);
-- obtener todos los tipo de mascota ordenados por ID
SELECT id, nombre FROM tipo_mascota ORDER BY id ASC
-- obtener ID dado un nombre de tipo de mascota
SELECT id FROM tipo_mascota WHERE nombre=?
