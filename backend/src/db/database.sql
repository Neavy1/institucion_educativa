----------------------------------------------------- PENDIENTES -----------------------------------------------------
--TODO:
--0. Eliminar tabla curso y pasar sus datos a la tabla grupo, CONSIDERA la posibilidad de eliminar la tabla matricula_academica en favor de historial_academico pero NO LO CREO
--0.1. eliminar la tala nota_estudiante_asignatura_matriculada em favor de asignaturas_aprobadas_estudiante_programa_academico, ahora la nota definitiva estará asociada a un estudiante, programa académico y asignatura y la nota de un grupo se calculará en ejecución con la tabla historial_academico
--0.2. validar que un estudiante no pueda matricular una asignatura que ya aprobó en la tabla asignaturas_aprobadas_estudiante_programa_academico
--//! cuando inserte muchos registros simultáneamente, como cuando calcule las notas de los estudiantes, no se podrán insertar datos duplicados en la tabla asignaturas_aprobadas_estudiante_programa_academico, por lo tanto la consulta fallará. Necesito que continúe ejecutándose y al final me notifique los registros que fallaron al insertarse
--1. Módulo de notas detallado y personalizable en cuanto a porcentajes
--2. Consulta que retorne el promedio de un estudiante en un programa academico en un periodo académico
--3. Consulta que retorne el promedio global de un estudiante en un programa academico
--4. Habilitaciones 
--5. Cancelaciones 
--6. Validar que el jefe de departamento y facultad solo dirija una cosa a la vez 
--7. Validar que el rector no pueda dirigir facultades ni departamentos 
--8. trigger para llenar los horarios de la tabla clase
--9. Historial académico completo del estudiante
--10. Añadir el anio_periodo_academico en la tabla docente_asignatura
--11. Estandarizar la nomenclatura de los id en varias tablas, como curso y grupo, que solo dice "id", cambiar por id_grupo e id_curso


----------------------------------------------------- CONSULTAS -----------------------------------------------------

/*//! Landing page
//*Lista de programas académicos, malla curricular de cada programa, asignaturas, cursos de extensión y detalles de cada uno, lista de profesores con sus fotos de perfil:
//* 1. Lista de programas académicos() => TODO de tabla programa_academico
//?Lista en el backend
SELECT * FROM programa_academico;

//* 2. Malla curricular de cada programa(id_programa_academico) => todos los id_asignatura de tabla pensum_programa_academico
//?Lista en el backend
SELECT asignatura.*
FROM pensum_programa_academico ppa
INNER JOIN programa_academico ON ppa.fk_id_programa_academico = programa_academico.id_programa_academico
INNER JOIN asignatura ON ppa.fk_id_asignatura = asignatura.id_asignatura
WHERE ppa.fk_id_programa_academico = <id_programa_academico>

//* 3. Asignaturas cursos de extensión + detalle() => TODO de tabla asignatura where asigatura.curso_extension == true
//!Funciona, revisar en el backend la forma en la que retorna los datos el UNION ALL y ver si combiene discriminar las asignaturas y los cursos de extensión así o hacer un filter en el backend
SELECT *
FROM asignatura
WHERE curso_extension = false
UNION ALL
SELECT *
FROM asignatura
WHERE curso_extension = true

//* 4. Obtener datos de un usuario según su rol
SELECT id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, url_foto, e.*, d.id_docente, d.fk_id_departamento, d.fk_id_tipo_contrato
FROM usuario u
LEFT JOIN detalle_estudiante e ON u.id_usuario = e.id_estudiante
LEFT JOIN detalle_docente d ON u.id_usuario = d.id_docente
LEFT JOIN detalle_administrativo a ON u.id_usuario = a.id_administrativo
WHERE u.id_usuario = ?;

//* 5. Lista de profesores con su nombre, apellido, departamento y foto de perfil(lista )
SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos, usuario.url_foto, detalle_docente.fk_id_departamento
FROM usuario
INNER JOIN detalle_docente ON usuario.id_usuario = detalle_docente.id_docente
WHERE usuario.id_usuario = detalle_docente.id_docente

//! LOGIN
//*Con el número de cédula y el rol (dado por el endpoint desde donde intenta acceder), consultar si el usuario existe, y si tiene ese rol asignado en la tabla asignacion_roles. Si es así, retornar el hash, la salt y validar la contraseña en el back.
//* 1. Login(id_usuario, id_rol)
//! comprobar en el backend si el usuario existe, si tiene ese rol asignado en la tabla asignacion_roles
SELECT usuario.id_usuario, usuario.contrasena_salt, usuario.contrasena_hash, asignacion_roles.fk_id_rol
FROM usuario
INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.fk_id_usuario
WHERE asignacion_roles.fk_id_usuario = 111
AND asignacion_roles.fk_id_rol = 2

//! PORTAL ADMINISTRATIVO
//*CREATE y UPDATE tablas: (id) => CREATE o UPDATE en tabla: usuario, asignatura, prerequisitos_asignatura, curso, grupo, horario_clase, docente_asignatura, matricula_academica
//? 1. INSERTS
//* 1.1. Crea usuario
INSERT INTO usuario (id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, contrasena_salt, contrasena_hash)
VALUES (1, 1, 'John', 'Doe', 'johndoe@example.com', '123456789', 'salt123', 'hash123')
(1115090873,1,'Jose','Salazar','neabyop@gmail.com','123456789', 'salt123', 'hash123'),
(2,2,'Juan Sebastian' , 'Florez' , 'sebastianflorez3@gmail.com','123456789', 'salt123', 'hash123');
//* 1.2. Crea dirección
INSERT INTO direccion (id_direccion, direccion, barrio, ciudad, departamento)
VALUES (1, 'Calle Principal 123', 'Centro', 'Ciudad Principal', 'Departamento Principal'),
//* 1.3. Asigna roles al usuario
INSERT INTO asignacion_roles (fk_id_usuario, fk_id_rol)
VALUES (1, 1),
VALUES (1, 1),
VALUES (1, 1);

//*1.4. Crear detalle_estudiante
INSERT INTO detalle_estudiante (id_estudiante, fk_id_estado_academico)
VALUES (2, 1);  

//*1.5. Crear detalle_docente
INSERT INTO detalle_docente (id_docente, fk_id_departamento, url_hoja_de_vida, salario, fk_id_tipo_contrato)
VALUES (3, 2, '<url_hoja_de_vida>', 10000, 1);

//*1.6. Crear detalle_administrativo
INSERT INTO detalle_administrativo (id_administrativo)
VALUES
  (1);

//*1.7. Asignar cargos administrativos
INSERT INTO detalle_administrativo_cargo_administrativo (fk_id_administrativo, fk_id_cargo_administrativo)
VALUES
  (1, 1);

//? 2. UPDATES
//*2.1. Actualizar tabla usuario
UPDATE usuario
SET sexo = 1,
    nombres = 'Juan Sebastian',
    apellidos = 'Florez',
    correo_electronico = 'sebastianflorez3@gmail.com',
    telefono = '123456789',
    url_foto = 'asdasdasd',
    contrasena_salt = 'salt123',
    contrasena_hash = 'hash123'
WHERE id_usuario = 2;

//*2.1. Actualizar tabla detalle_estudiante
UPDATE detalle_estudiante
SET fk_id_estado_academico = 1  
WHERE id_estudiante = 2;  

//*2.2. Actualizar tabla detalle_docente
UPDATE detalle_docente
SET fk_id_departamento = 2,
    url_hoja_de_vida = '<url_hoja_de_vida>',
    salario = 10000,
    fk_id_tipo_contrato = 1
WHERE id_docente = 3;

//*2.3. Eliminación de roles de usuarios en la tabla asignacion_roles(id_usuario, id_rol)
DELETE FROM asignacion_roles
WHERE fk_id_usuario = [1] AND fk_id_rol = [2];

//* 3. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
UPDATE usuario
SET contrasena_salt = 'nueva_contrasena_salt',
    contrasena_hash = 'nueva_contrasena_hash'
WHERE id_usuario = 1;

//* 4. Total de estudiantes matriculados en un periodo académico en TODA la institución educativa(anio, id_periodo_academico)
SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
WHERE oa.fk_id_anio_periodo_academico = (
SELECT id_anio_periodo_academico
FROM anio_periodo_academico
WHERE anio = [1] AND fk_id_periodo_academico = [2]
);

//* 5. Total de estudiantes matriculados en un periodo académico en un programa académico(anio, id_periodo_academico, id_programa_academico)

SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
WHERE oa.fk_id_anio_periodo_academico = (
SELECT id_anio_periodo_academico
FROM anio_periodo_academico
WHERE anio = 2023 AND fk_id_periodo_academico = 1 AND oa.fk_id_programa_academico = 1
);

//! PORTAL DOCENTE
//*Ver lista de grupos con la asignatura de cada grupo (docente_asignatura), ver los horarios de todos los cursos, ver los estudiantes, el grupo al que pertenecen y sus notas, agregar y editar notas (historial_academico), información de perfil (usuario y detalle), cambiar contraseña

//* 1. Obtener información de un docente
SELECT usuario.*, detalle_docente.*
FROM usuario, detalle_docente
WHERE usuario.id_usuario = 111 AND detalle_docente.id_docente = 111

//* 2. Ver las asignaturas que enseña un docente(id_docente)
SELECT asignatura.*
FROM docente_asignatura
INNER JOIN asignatura ON docente_asignatura.fk_id_asignatura = asignatura.id_asignatura
WHERE docente_asignatura.fk_id_docente = 111;

//* 3. Ver horario de un docente(id_docente, anio, id_periodo_academico)
SELECT
  grupo.id,
  grupo.numero_grupo,
  asignatura.nombre,
  dia_semana.nombre_dia_semana,
  clase.hora_inicio,
  clase.hora_final,
  ubicacion_clase.id_edificio,
  ubicacion_clase.id_salon
FROM horario_clase
INNER JOIN grupo ON horario_clase.fk_id_grupo = grupo.id
INNER JOIN curso ON grupo.fk_id_curso = curso.id
INNER JOIN asignatura ON curso.fk_id_asignatura = asignatura.id_asignatura
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana = dia_semana.id_dia_semana
INNER JOIN clase ON clase_dia.fk_id_clase = clase.id_clase
INNER JOIN ubicacion_clase ON horario_clase.fk_id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE grupo.id IN (
//* 3.2. Lista de grupos en los que enseña un docente en un periodo académico(id_docente, anio, id_periodo_academico)
  SELECT grupo.id
  FROM grupo
  INNER JOIN curso ON grupo.fk_id_curso = curso.id
  INNER JOIN oferta_academica ON curso.fk_id_oferta_academica = oferta_academica.id_oferta_academica
  INNER JOIN anio_periodo_academico ON oferta_academica.fk_id_anio_periodo_academico = anio_periodo_academico.id_anio_periodo_academico
  WHERE grupo.fk_id_docente_asignado = <id_docente> 
  AND anio_periodo_academico.anio = <anio> 
  AND anio_periodo_academico.fk_id_periodo_academico= <id_periodo_academico>
  );

//* 4. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
UPDATE usuario
SET contrasena_salt = 'nueva_contrasena_salt',
    contrasena_hash = 'nueva_contrasena_hash'
WHERE id_usuario = 1;

//* 5. Modificar notas(id_estudiante, id_grupo, nota1, nota2, nota3, nota4) => UPDATE en tabla historial_academico * notas
UPDATE historial_academico
SET nota_1 = 1.4,
    nota_2 = 2.4,
    nota_3 = 3.4,
    nota_4 = 4.4
WHERE fk_id_grupo = 1 AND fk_id_estudiante = 123;

//! PORTAL ESTUDIANTIL
//*Ver los cursos en los que está matriculado y su horario, ver lista de asignaturas matriculadas (ambas cosas se miran en la tabla grupo). ver los programas académicos en los que está registrado, --- la malla curriculado --- y las ---asignaturas aprobadas, matriculadas y no aprobadas --- (nota_estudiante_asignatura_matriculada), ver notas parciales (historial_academico) y notas finales (nota_estudiante_asignatura_matriculada), información de perfil (usuario y detalle), cambiar contraseña
//* 1. SELECT id_anio_periodo_academico() (lo saca de la tabla institucion_educativa)
SELECT id_anio_periodo_academico
FROM anio_periodo_academico
JOIN institucion_educativa ON anio_periodo_academico.anio = institucion_educativa.anio_vigente
AND anio_periodo_academico.fk_id_periodo_academico = institucion_educativa.periodo_academico_vigente;

//* 2. Lista de ofertas académicas de un estudiante(id_estudiante, anio, id_periodo_academico)
SELECT
  ma.fk_id_oferta_academica,
  pa.id_programa_academico,
  pa.nombre,
  pa.total_creditos
FROM
  matricula_academica ma
JOIN
  oferta_academica oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
JOIN
  programa_academico pa ON oa.fk_id_programa_academico = pa.id_programa_academico
WHERE
  ma.fk_id_estudiante = 123
  AND oa.fk_id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = 2023 AND fk_id_periodo_academico = 1
  );

//* 3. Historial del estudiante en todos sus grupos de una anio y id_periodo_academico(id_estudiante, anio, id_periodo_academico)
SELECT
  historial_academico.fk_id_grupo,
  grupo.numero_grupo,
  curso.fk_id_asignatura,
  asignatura.nombre AS nombre_asignatura,
  historial_academico.nota_1,
  historial_academico.nota_2,
  historial_academico.nota_3,
  historial_academico.nota_4
FROM
  historial_academico
JOIN grupo ON historial_academico.fk_id_grupo = grupo.id
JOIN curso ON grupo.fk_id_curso = curso.id
JOIN asignatura ON curso.fk_id_asignatura = asignatura.id_asignatura
JOIN oferta_academica ON curso.fk_id_oferta_academica = oferta_academica.id_oferta_academica
WHERE historial_academico.fk_id_estudiante = 123 
AND oferta_academica.fk_id_anio_periodo_academico IN (
SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = 2023 AND fk_id_periodo_academico = 1
);

//* 3. Historial del estudiante en TODA su historia(id_estudiante)
//! Es mejor dejarlo para post entrega :v
SELECT
  historial_academico.fk_id_grupo,
  grupo.numero_grupo,
  curso.fk_id_asignatura,
  asignatura.nombre AS nombre_asignatura,
  historial_academico.nota_1,
  historial_academico.nota_2,
  historial_academico.nota_3,
  historial_academico.nota_4
FROM
  historial_academico
JOIN grupo ON historial_academico.fk_id_grupo = grupo.id
JOIN curso ON grupo.fk_id_curso = curso.id
JOIN asignatura ON curso.fk_id_asignatura = asignatura.id_asignatura
JOIN oferta_academica ON curso.fk_id_oferta_academica = oferta_academica.id_oferta_academica
WHERE historial_academico.fk_id_estudiante = 123;

//* 5. Obtener la matrícula académica de un estudiante(id_estudiante, id_oferta_academica)
SELECT id_matricula_academica
FROM matricula_academica
WHERE fk_id_estudiante = 123 AND fk_id_oferta_academica = 1;

//* 6. Historial de notas del semestre(id_estudiante, id_oferta_academica)
SELECT a.id_asignatura, a.nombre, n.nota_final_estudiante_asignatura
FROM nota_estudiante_asignatura_matriculada n
JOIN asignatura a ON n.fk_id_asignatura = a.id_asignatura
JOIN matricula_academica ma ON n.fk_id_matricula_academica = ma.id_matricula_academica
WHERE ma.fk_id_estudiante = 123 AND ma.fk_id_oferta_academica = 1;

//* 7. Obtener información de un estudiante
SELECT usuario.*, detalle_estudiante.*
FROM usuario, detalle_estudiante
WHERE usuario.id_usuario = 123 AND detalle_estudiante.id_estudiante = 123

//* 8. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
UPDATE usuario
SET contrasena_salt = 'nueva_contrasena_salt',
    contrasena_hash = 'nueva_contrasena_hash'
WHERE id_usuario = 1;

//* 9. Créditos matriculados por un estudiante en un periodo académico y en un programa académico(d_estudiante, id_programa_academico, anio, id_periodo_tiempo)
SELECT SUM(a.num_creditos) AS total_creditos_matriculados
FROM nota_estudiante_asignatura_matriculada AS n
INNER JOIN matricula_academica AS m ON n.fk_id_matricula_academica = m.id_matricula_academica
INNER JOIN oferta_academica AS o ON m.fk_id_oferta_academica = o.id_oferta_academica
INNER JOIN asignatura AS a ON n.fk_id_asignatura = a.id_asignatura
WHERE m.fk_id_estudiante = 123
  AND o.fk_id_programa_academico = 1
  AND o.fk_id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = 2023 AND fk_id_periodo_academico = 1
  );

//* 10. Ubicación semestral de un estudiante en un programa académico(id_estudiante, id_oferta_academica)
SELECT subquery.creditos_aprobados, subquery.creditos_totales, ROUND(subquery.creditos_aprobados/subquery.creditos_totales * 100, 2) AS ratio_aprobado
FROM (
  SELECT SUM(asignatura.num_creditos) AS creditos_aprobados, pa.total_creditos AS creditos_totales
  FROM asignaturas_aprobadas_estudiante_programa_academico AS aaepa
  INNER JOIN asignatura ON aaepa.fk_id_asignatura = asignatura.id_asignatura
  INNER JOIN oferta_academica oa ON aaepa.fk_id_oferta_academica = oa.id_oferta_academica
  INNER JOIN programa_academico pa ON oa.fk_id_programa_academico = pa.id_programa_academico
  WHERE aaepa.fk_id_estudiante = 123 
  AND aaepa.fk_id_oferta_academica = 1
) subquery;

//* 11. Último periodo académico que matriculó un estudiante(id_estudiante)
SELECT ap.anio, ap.fk_id_periodo_academico AS periodo_academico
FROM matricula_academica AS ma
INNER JOIN oferta_academica AS oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
WHERE ma.fk_id_estudiante = 123
ORDER BY ap.anio DESC, ap.fk_id_periodo_academico DESC
LIMIT 1;

//* 12. Registro nota final estudiante en un grupo(id_estudiante, id_grupo)
TODO: Esta función se va a eliminar en favor de la 13+1
INSERT INTO nota_estudiante_asignatura_matriculada (fk_id_matricula_academica, fk_id_asignatura, nota_final_estudiante_asignatura)
SELECT ma.id_matricula_academica, curso.fk_id_asignatura, ((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4) AS promedio
FROM historial_academico ha
INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
INNER JOIN curso ON grupo.fk_id_curso = curso.id
INNER JOIN matricula_academica ma ON ha.fk_id_estudiante = ma.fk_id_estudiante
WHERE ha.id in (
  SELECT id
  FROM historial_academico
  WHERE ha.fk_id_estudiante = 123
  AND ha.fk_id_grupo = 1
)
ON DUPLICATE KEY UPDATE nota_final_estudiante_asignatura = (ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4;

//* 13. Registrar como aprobada una asignatura por un estudiante si su nota en el grupo es >= 3(id_estudiante, id_grupo)
INSERT INTO asignaturas_aprobadas_estudiante_programa_academico (fk_id_estudiante, fk_id_oferta_academica, fk_id_asignatura, nota_final_estudiante_asignatura)
SELECT id_estudiante, id_oferta_academica, id_asignatura, nota_asignatura
FROM (
  SELECT ha.fk_id_estudiante AS id_estudiante, oa.id_oferta_academica AS id_oferta_academica, curso.fk_id_asignatura AS id_asignatura, ROUND((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4, 1) AS nota_asignatura
  FROM historial_academico ha
  INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
  INNER JOIN curso ON grupo.fk_id_curso = curso.id
  INNER JOIN oferta_academica oa ON curso.fk_id_oferta_academica = oa.id_oferta_academica
  WHERE ha.fk_id_estudiante = 123
    AND ha.fk_id_grupo = 1
) AS subquery
HAVING nota_asignatura >= 3;

//* 14. Promedio de un estudiante en una oferta academica(id_estudiante, id_oferta_academica)
//! Hay que probarlo con más datos cuando los estudiantes tengan más notas
SELECT AVG(ROUND((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4, 1)) AS promedio_semestral
  FROM historial_academico ha
  INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
  INNER JOIN curso ON grupo.fk_id_curso = curso.id
  INNER JOIN oferta_academica oa ON curso.fk_id_oferta_academica = oa.id_oferta_academica
  WHERE ha.fk_id_estudiante = 123
  AND curso.fk_id_oferta_academica = 1;
*/


/*//! Landing page
//* 1. Lista de programas académicos() => TODO de tabla programa_academico
//?Lista en el backend
//* 2. Malla curricular de cada programa(id_programa_academico) => todos los id_asignatura de tabla pensum_programa_academico
//* 3. Asignaturas cursos de extensión + detalle() => TODO de tabla asignatura where asigatura.curso_extension == true
//* 4. Obtener datos de un usuario según su rol
//* 5. Lista de profesores con su nombre, apellido, departamento y foto de perfil(lista )
//! LOGIN
//* 1. Login(id_usuario, id_rol)
//*CREATE y UPDATE tablas: (id) => CREATE o UPDATE en tabla: usuario, asignatura, prerequisitos_asignatura, curso, grupo, horario_clase, docente_asignatura, matricula_academica
//* 1.1. Crea usuario
//* 1.2. Crea dirección
//* 1.3. Asigna roles al usuario
/
/*1.4. Crear detalle_estudiante
//*1.5. Crear detalle_docente
//*1.6. Crear detalle_administrativo
//*1.7. Asignar cargos administrativos
//? 2. UPDATES
//*2.1. Actualizar tabla usuario
//*2.1. Actualizar tabla detalle_estudiante
//*2.2. Actualizar tabla detalle_docente
//*2.3. Eliminación de roles de usuarios en la tabla asignacion_roles(id_usuario, id_rol)
//* 3. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
//* 4. Total de estudiantes matriculados en un periodo académico en TODA la institución educativa(anio, id_periodo_academico)
//* 5. Total de estudiantes matriculados en un periodo académico en un programa académico(anio, id_periodo_academico, id_programa_academico)
//! PORTAL DOCENTE
//* 1. Obtener información de un docente
//* 2. Ver las asignaturas que enseña un docente(id_docente)
//* 3. Ver horario de un docente(id_docente, anio, id_periodo_academic
//* 3.2. Lista de grupos en los que enseña un docente en un periodo académico(id_docente, anio, id_periodo_academico)
//* 4. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
//* 5. Modificar notas(id_estudiante, id_grupo, nota1, nota2, nota3, nota4) => UPDATE en tabla historial_academico * notas
//! PORTAL ESTUDIANTIL
//* 1. SELECT id_anio_periodo_academico() (lo saca de la tabla institucion_educativa)
//* 2. Lista de ofertas académicas de un estudiante(id_estudiante, anio, id_periodo_academico)
//* 3. Historial del estudiante en todos sus grupos de una anio y id_periodo_academico(id_estudiante, anio, id_periodo_academico)
//* 3. Historial del estudiante en TODA su historia(id_estudiante)
//* 5. Obtener la matrícula académica de un estudiante(id_estudiante, id_oferta_academica)
//* 6. Historial de notas del semestre(id_estudiante, id_oferta_academica)
//* 7. Obtener información de un estudiante
//* 8. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
//* 9. Créditos matriculados por un estudiante en un periodo académico y en un programa académico(d_estudiante, id_programa_academico, anio, id_periodo_tiempo)
//* 10. Ubicación semestral de un estudiante en un programa académico(id_estudiante, id_oferta_academica)
//* 11. Último periodo académico que matriculó un estudiante(id_estudiante)
//* 12. Registro nota final estudiante en un grupo(id_estudiante, id_grupo)
//* 13. Registrar como aprobada una asignatura por un estudiante si su nota en el grupo es >= 3(id_estudiante, id_grupo)
//* 14. Promedio de un estudiante en una oferta academica(id_estudiante, id_oferta_academica)