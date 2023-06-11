CREATE DATABASE IF NOT EXISTS institucion_educativa;

USE institucion_educativa;

CREATE TABLE `institucion_educativa` (
  `id_institucion_educativa` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_institucion_educativa` varchar(100) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  `fk_id_rector` int NOT NULL
);

CREATE TABLE `facultad` (
  `id_facultad` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_facultad` varchar(100) NOT NULL,
  `ubicacion` varchar(100),
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_director_facultad` int NOT NULL
);

CREATE TABLE `departamento` (
  `id_departamento` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_departamento` varchar(100) NOT NULL,
  `fk_id_facultad` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_jefe_departamento` int NOT NULL
);

CREATE TABLE `rol` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL
);

CREATE TABLE `permiso` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_permiso` varchar(50) NOT NULL,
  `descripcion` varchar(100)
);

CREATE TABLE `sexo` (
  `id_sexo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_sexo` varchar(50) NOT NULL
);

CREATE TABLE `estado_academico` (
  `id_estado_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_estado_academico` varchar(50) NOT NULL
);

CREATE TABLE `direccion` (
  `id_direccion` int PRIMARY KEY,
  `direccion` varchar(100) NOT NULL,
  `barrio` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `departamento` varchar(100) NOT NULL
);

CREATE TABLE `usuario` (
  `id_usuario` int PRIMARY KEY,
  `sexo` int NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) UNIQUE NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `contrasena_salt` varchar(100) NOT NULL,
  `contrasena_hash` varchar(100) NOT NULL
);

CREATE TABLE `detalle_estudiante` (
  `id_estudiante` int PRIMARY KEY,
  `fk_id_estado_academico` int NOT NULL
);

CREATE TABLE `detalle_docente` (
  `id_docente` int PRIMARY KEY,
  `fk_id_departamento` int NOT NULL,
  `url_hoja_de_vida` varchar(100),
  `salario` int NOT NULL,
  `fk_id_tipo_contrato` int NOT NULL
);

CREATE TABLE `tipo_contrato` (
  `id_tipo_contrato` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_contrato` varchar(100) NOT NULL
);

CREATE TABLE `detalle_administrativo` (
  `id_administrativo` int PRIMARY KEY
);

CREATE TABLE `cargo_administrativo` (
  `id_cargo_administrativo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_cargo_administrativo` varchar(100) NOT NULL,
  `descripcion_cargo_administrativo` varchar(100)
);

CREATE TABLE `periodo_academico` (
  `id_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50)
);

CREATE TABLE `anio_periodo_academico` (
  `id_anio_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `anio` int,
  `fk_id_periodo_academico` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fecha_matricula` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL
);

CREATE TABLE `programa_academico` (
  `id_programa_academico` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_facultad` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `total_creditos` int NOT NULL,
  `fk_id_director` int NOT NULL
);

CREATE TABLE `asignatura` (
  `id_asignatura` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_departamento` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `num_creditos` int,
  `max_estudiantes` int NOT NULL
);

CREATE TABLE `dia_semana` (
  `id_dia_semana` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_dia_semana` varchar(20) NOT NULL
);

CREATE TABLE `clase` (
  `id_clase` int PRIMARY KEY,
  `hora_inicio` int NOT NULL,
  `hora_final` int NOT NULL
);

CREATE TABLE `clase_dia` (
  `id_clase_dia` int PRIMARY KEY,
  `fk_id_dia_semana` int NOT NULL,
  `fk_id_clase` int NOT NULL
);

CREATE TABLE `ubicacion_clase` (
  `id_ubicacion_clase` int PRIMARY KEY,
  `id_edificio` int,
  `id_salon` int,
  `nombre` varchar(100),
  `descripcion` varchar(150)
);

CREATE TABLE `oferta_academica` (
  `id_oferta_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_anio_periodo_academico` int NOT NULL,
  `fk_id_programa_academico` int NOT NULL
);

CREATE TABLE `matricula_academica` (
  `id_matricula_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_estudiante` int NOT NULL
);

CREATE TABLE `curso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `grupo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_curso` int NOT NULL,
  `numero_grupo` int NOT NULL,
  `id_docente_asignado` int NOT NULL
);

CREATE TABLE `horario_clase` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_clase_dia` int NOT NULL,
  `fk_id_ubicacion_clase` int NOT NULL
);

CREATE TABLE `historial_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_estudiante` int NOT NULL,
  `nota_estudiante_curso` float
);

CREATE TABLE `nota_estudiante_asignatura_matriculada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_matricula_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL,
  `nota_final_estudiante_asignatura` int
);

CREATE TABLE `creditos_aprobados_estudiante_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_estudiante` int,
  `fk_id_programa_academico` int NOT NULL,
  `total_creditos_aprobados` int
);

CREATE TABLE `prerequisitos_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_asignatura` int NOT NULL,
  `fk_id_asignatura_prerequisito` int NOT NULL
);

CREATE TABLE `rol_permiso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_rol` int NOT NULL,
  `fk_id_permiso` int NOT NULL
);

CREATE TABLE `asignacion_roles` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` int NOT NULL,
  `fk_id_rol` int NOT NULL
);

CREATE TABLE `docente_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_docente` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `pensum_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_programa_academico` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `detalle_administrativo_cargo_administrativo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_administrativo` int NOT NULL,
  `fk_id_cargo_administrativo` int NOT NULL
);

-------------------------------------------------------- ÍNDICES --------------------------------------------------------
CREATE UNIQUE INDEX `anio_periodo_academico_index_0` ON `anio_periodo_academico` (`anio`, `fk_id_periodo_academico`);

CREATE UNIQUE INDEX `clase_index_1` ON `clase` (`hora_inicio`, `hora_final`);

CREATE UNIQUE INDEX `clase_dia_index_2` ON `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`);

CREATE UNIQUE INDEX `oferta_academica_index_3` ON `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `matricula_academica_index_4` ON `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `curso_index_5` ON `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `grupo_index_6` ON `grupo` (`fk_id_curso`, `numero_grupo`);

CREATE UNIQUE INDEX `horario_clase_index_7` ON `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`);

CREATE UNIQUE INDEX `horario_clase_index_8` ON `horario_clase` (`fk_id_clase_dia`, `fk_id_ubicacion_clase`);

CREATE UNIQUE INDEX `historial_academico_index_9` ON `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `nota_estudiante_asignatura_matriculada_index_10` ON `nota_estudiante_asignatura_matriculada` (`fk_id_matricula_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `creditos_aprobados_estudiante_programa_academico_index_11` ON `creditos_aprobados_estudiante_programa_academico` (`fk_id_estudiante`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `prerequisitos_asignatura_index_12` ON `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`);

CREATE UNIQUE INDEX `rol_permiso_index_13` ON `rol_permiso` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `asignacion_roles_index_14` ON `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`);

CREATE UNIQUE INDEX `docente_asignatura_index_15` ON `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `pensum_programa_academico_index_16` ON `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `detalle_administrativo_cargo_administrativo_index_17` ON `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`);

-------------------------------------------------------- LLAVES FORÁNEAS --------------------------------------------------------

ALTER TABLE `institucion_educativa` ADD FOREIGN KEY (`fk_id_rector`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_director_facultad`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_jefe_departamento`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `direccion` ADD FOREIGN KEY (`id_direccion`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`sexo`) REFERENCES `sexo` (`id_sexo`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`fk_id_estado_academico`) REFERENCES `estado_academico` (`id_estado_academico`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`id_docente`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_tipo_contrato`) REFERENCES `tipo_contrato` (`id_tipo_contrato`);

ALTER TABLE `detalle_administrativo` ADD FOREIGN KEY (`id_administrativo`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `periodo_academico` (`id_periodo_academico`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_director`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `asignatura` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_dia_semana`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_clase`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_anio_periodo_academico`) REFERENCES `anio_periodo_academico` (`id_anio_periodo_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_curso`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`id_docente_asignado`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_clase_dia`) REFERENCES `clase_dia` (`id_clase_dia`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_ubicacion_clase`) REFERENCES `ubicacion_clase` (`id_ubicacion_clase`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_matricula_academica`) REFERENCES `matricula_academica` (`id_matricula_academica`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura_prerequisito`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_permiso`) REFERENCES `permiso` (`id_permiso`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_docente`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_administrativo`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_cargo_administrativo`) REFERENCES `cargo_administrativo` (`id_cargo_administrativo`);

-------------------------------------------------------- TRIGGERS --------------------------------------------------------

-- 1. validar que un estudiante no pueda matricular una asignatura que ya aprobó en la tabla nota_estudiante_asignatura_matriculada
DELIMITER $$
CREATE TRIGGER validar_asignatura_abrobada
BEFORE INSERT ON nota_estudiante_asignatura_matriculada
FOR EACH ROW
BEGIN
  DECLARE nota_existente FLOAT;
  -- Obtener la nota final de la asignatura para el estudiante actual
  SELECT nota_final_estudiante_asignatura INTO nota_existente
  FROM nota_estudiante_asignatura_matriculada
  WHERE fk_id_matricula_academica = NEW.fk_id_matricula_academica
    AND fk_id_asignatura = NEW.fk_id_asignatura
    AND nota_final_estudiante_asignatura >= 3.0
  LIMIT 1;
  -- Verificar si el estudiante ya ha aprobado la asignatura
  IF nota_existente IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El estudiante ya ha aprobado la asignatura';
  END IF;
END$$
DELIMITER ; 

-------------------------------------------------------- CONSULTAS --------------------------------------------------------

----------------------------------------------------- NO REVISADAS PERO NI PROBADAS -----------------------------------------------------

-- Obtener información resumida cursos de extensión
SELECT asignatura.nombre, asignatura.num_creditos, clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana

-- Obtener información curso de extensión en detalle 
SELECT asignatura.nombre, asignatura.num_creditos, asignatura.max_estudiantes, prerequisitos_asignatura.fk_id_asignatura_prerequisito,
       clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana, usuario.nombres AS nombre_docente, usuario.apellidos AS apellidos_docente,
       ubicacion_clase.id_edificio, ubicacion_clase.id_salon
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana 
INNER JOIN usuario ON grupo.id_docente_asignado=usuario.id_usuario
INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
INNER JOIN ubicacion_clase ON horario_clase.fk_id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE asignatura.nombre = "Laboratorio de Software";

    --Para obtener el nombre de la asignatura prerrequisito
    SELECT asignatura.nombre
    FROM asignatura 
    INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
    WHERE prerequisitos_asignatura.fk_id_asignatura_prerequisito = "IS673"


-- Log in, no sé cual de los campos de contrasena se debe utilizar :°D (pero creo que se entiende la idea)
SELECT usuario.id_usuario, usuario.contrasena, asignacion_roles.fk_id_rol, usuario.nombres, usuario.apellidos
FROM usuario 
INNER JOIN asignacion_roles ON usuario.id_usuario=asignacion_roles.fk_id_usuario
WHERE usuario.id_usuario = '123456789' AND usuario.contrasena = 'contrasena123'; 

-- Ver informacion personal 
SELECT  usuario.sexo, usuario.nombres, usuario.apellidos, usuario.correo_electronico, usuario.telefono, usuario.contrasena_salt,
        direccion.direccion, direccion.barrio, direccion.ciudad, direccion.departamento
FROM usuario 
INNER JOIN direccion ON usuario.id_usuario=direccion.id_direccion
WHERE usuario.id_usuario="12345";
           
-- Ver información laboral
SELECT detalle_docente.url_hoja_de_vida, detalle_docente.salario, tipo_contrato.nombre_contrato, departamento.nombre_departamento
FROM detalle_docente 
INNER JOIN tipo_contrato ON detalle_docente.fk_id_tipo_contrato = tipo_contrato.id_tipo_contrato
INNER JOIN departamento ON detalle_docente.fk_id_departamento = departamento.nombre_departamento
WHERE detalle_docente.id_docente ="12345";


  -- Insertar tipo contrato (si sabe bien cuales son se pueden agregar)
    INSERT INTO tipo_contrato (id_tipo_contrato, nombre_contrato)
    VALUES ('1', 'Planta'), ('2', 'Transitorio'), ('3', 'Catedratico');


-- Ver información académica (créditos disponibles es un valor estático en la UTP son como 27 creditos por semestre)
-- Nota: no sé como poner la ubicación semestral
SELECT estado_academico.nombre_estado_academico, programa_academico.nombre AS programa_academico, SUM(asignatura.num_creditos) AS creditos_matriculados
FROM detalle_estudiante 
INNER JOIN estado_academico ON detalle_estudiante.fk_id_estado_academico = estado_academico.id_estado_academico
INNER JOIN matricula_academica ON matricula_academica.fk_id_estudiante = detalle_estudiante.id_estudiante
INNER JOIN oferta_academica ON oferta_academica.id_oferta_academica = matricula_academica.fk_id_oferta_academica
INNER JOIN programa_academico ON programa_academico.id_programa_academico = oferta_academica.fk_id_programa_academico
INNER JOIN curso ON oferta_academica.id_oferta_academica = curso.fk_id_oferta_academica
INNER JOIN asignatura ON curso.fk_id_asignatura = asignatura.id_asignatura
WHERE detalle_estudiante.id_estudiante = "12345"

    -- Insertar estado academico (si sabe bien cuales son se pueden agregar)
    INSERT INTO estado_academico (id_estado_academico, nombre_estado_academico)
    VALUES ('1', 'Activo'), ('2', 'Inactivo');

-- Editar perfil (Para la direccion tendría que poner en el formulario los campos necesarios)
UPDATE usuarios SET telefono = '555-4321' WHERE documento_identidad = '123456789';
UPDATE direccion SET direccion = 'Carrera 1 Calle 2-3' WHERE id_direccion = '123456789';

-- Registrar informacion personal y de usuario de nuevo usuario (suponiendo que id_rol 1 equivale a Administrativo)
INSERT INTO direccion(id_direccion, direccion, barrio, ciudad, departamento)
VALUES ('123456789', 'Carrera 1 Calle 2-3', 'Un barrio','Pereira', 'Risaralda');

INSERT INTO usuario (id_usuario, sexo, nombres, apellidos, correo_electronico, telefono, contrasena_salt, contrasena.hash)
VALUES ('123456789', '1', 'Juan','Perez', 'juanperez@institucion.edu.co', '555-1234', '123', 'contrasena123','ef4536abcd689');

INSERT INTO asignacion_roles(id, fk_id_usuario, fk_id_rol)
VALUES (NULL, '123456789', '1');

-- Registrar informacion laboral de nuevo usuario
INSERT INTO detalle_docente (id_docente, fk_id_departamento, url_hoja_de_vida, salario. fk_id_tipo_contrato)
VALUES ('987654321', '1', 'Www.unaurl.com', '5 000 000', '3');

-- Registrar informacion academica de nuevo usuario 
INSERT INTO detalle_estudiante(id_estudiante, fk_id_estado_academico)
VALUES ('123456789', '1');

INSERT INTO (id_matricula_academica, fk_id_oferta_academica, fk_id_estudiante)
VALUES (NULL, '1','123456789');

-- Ver información de docentes y estudiantes desde Rol administrativo (suponiendo id_rol: 2-Docente y 3-Estudiante)

    --Por documento de identidad
    SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos 
    FROM usuario
    INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.fk_id_usuario
    WHERE asignacion_roles.fk_id_usuario = '2' AND usuario.id_usuario LIKE "123%"
    ORDER BY usuario.id_usuario ASC;

    --Por Apellidos
    SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos 
    FROM usuario
    INNER JOIN asignacion_roles ON usuario.id_usuario = asignacion_roles.fk_id_usuario
    WHERE asignacion_roles.fk_id_usuario = '3' AND usuario.apellidos LIKE "Pe%"
    ORDER BY usuario.apellidos ASC;

--Editar información laboral docentes desde Rol Administrativo (2 = Transitorio)
UPDATE detalle_docente SET fk_id_tipo_contrato = '2' WHERE id_docente = '987654321';

-- Facultad
INSERT INTO facultad (id_facultad, nombre_facultad, ubicacion, fk_id_institucion_educativa, fk_id_director_facultad)
VALUES ('1', 'Facultad de ingenierías','Edificio 3', '1', '1');

-- Programa academico
INSERT INTO programa_academico (id_programa_academico, fk_id_facultad, nombre, total_creditos, fk_id_director)
VALUES ('1', '1','Ingenieria de Sistemas', 183, '1');

-- Periodo academico 
INSERT INTO periodo_academico (id_periodo_academico, nombre, descripcion)
VALUES ('1', 'Semestre 1','Blah blah blah');

-- anio periodo academico 
INSERT INTO periodo_academico (id_anio_periodo_academico,anio, fk_id_periodo_academico, fk_id_institucion_educativa, fecha_matricula, fecha_inicio, fecha_final)
VALUES ('1', '2023', '1', '1', '24-01-2023', '06-02-2023','16-06-2023', 'Blah blah blah');

-- Periodo academico 
INSERT INTO periodo_academico (id_periodo_academico, nombre, descripcion)
VALUES ('1', 'Semestre 1','Blah blah blah');

-- Crear asignatura (Los id de asignatura los puse así (y no como int) por que es mas facil de visualizar)
    --Información de asignatura (intensidad horaria puede ser 4 horas semanales)
    INSERT INTO asignatura (id_asignatura, fk_id_departamento, nombre, num_creditos, max_estudiantes)
    VALUES ('IS873','1', 'Laboratorio de software','3', 36);

    INSERT INTO pensum_programa_academico (id, fk_id_programa_academico, fk_id_asignatura)
    VALUES (NULL,'1', 'IS873',);

    INSERT INTO prerequisitos_asignatura (id, fk_id_asignatura, fk_id_asignatura_prerequisito)
    VALUES (NULL,'IS873', 'IS714',);


    --Información de grupo o de clase (Suponiendo que este es el curso 1)
    INSERT INTO curso (id, fk_id_oferta_academica, fk_id_asignatura, fk_id_docente_asignado)
    VALUES (NULL, '1', 'IS873', '987654321');

    INSERT INTO grupo (id, fk_id_curso, numero_grupo, id_docente_asignado)
    VALUES ('1', '1', '987654321');

    INSERT INTO clase (id_clase, hora_inicio, hora_final)
    VALUES ('11', '2', '4');

    INSERT INTO clase_dia (id_clase_dia, fk_id_dia_semana, fk_id_clase)
    VALUES ('111', '2', '11');

    INSERT INTO horario_clase (id, fk_id_grupo, fk_id_clase_dia, fk_id_ubicacion_clase)
    VALUES (NULL, '1', '111', '1');

    --Ubicación clase no está atado a una clase, simplemente estan los salones de clase
    INSERT INTO clase_dia (id_ubicacion_clase, id_edificio, id_salon, nombre, descripcion)
    VALUES ('1', '3', '201','Edificio 3', 'Salon maximo 30 estudiantes');

-- Ver asignatura desde rol administrativo (Cuando se busca, la informacion es resumida)
  --Por Codigo (en el docente no inclute asignatura.programa_academico)
    SELECT asignatura.id_asignatura, asignatura.nombre, programa_academico.nombre AS programa_academico
    FROM asignatura 
    INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
    INNER JOIN programa_academico ON pensum_programa_academico.fk_id_programa_academico = programa_academico.id_programa_academico
    WHERE asignatura.id_asignatura LIKE "IS8%"
    ORDER BY asignatura.id_asignatura ASC;

  --Por Nombre
    SELECT asignatura.id_asignatura, asignatura.nombre, programa_academico.nombre AS programa_academico
    FROM asignatura 
    INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
    INNER JOIN programa_academico ON pensum_programa_academico.fk_id_programa_academico = programa_academico.id_programa_academico
    WHERE asignatura.nombre LIKE "Labora%"
    ORDER BY asignatura.nombre ASC;

-- Ver información de asignatura en detalle
SELECT asignatura.nombre, asignatura.num_creditos, asignatura.max_estudiantes, prerequisitos_asignatura.fk_id_asignatura_prerequisito,
       clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana, usuario.nombres AS nombre_docente, usuario.apellidos AS apellidos_docente,
       ubicacion_clase.id_edificio, ubicacion_clase.id_salon
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON curso.id = grupo.fk_id_curso
INNER JOIN horario_clase ON grupo.id = horario_clase.fk_id_grupo
INNER JOIN clase_dia ON horario_clase.fk_id_clase_dia = clase_dia.id_clase_dia
INNER JOIN clase ON clase_dia.fk_id_clase=clase.id_clase 
INNER JOIN dia_semana ON clase_dia.fk_id_dia_semana=dia_semana.id_dia_semana 
INNER JOIN usuario ON grupo.id_docente_asignado=usuario.id_usuario
INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
INNER JOIN ubicacion_clase ON horario_clase.fk_id_ubicacion_clase = ubicacion_clase.id_ubicacion_clase
WHERE asignatura.nombre = "Laboratorio de Software";

--Para obtener el nombre de la asignatura prerrequisito
    SELECT asignatura.nombre
    FROM asignatura 
    INNER JOIN prerequisitos_asignatura ON asignatura.id_asignatura = prerequisitos_asignatura.fk_id_asignatura_prerequisito
    WHERE prerequisitos_asignatura.fk_id_asignatura_prerequisito = "IS673"

-- Ver asignatura de mi programa academico (Se debe conocer el programa academico)
SELECT asignatura.id_asignatura, asignatura.nombre, pensum_programa_academico.fk_id_programa_academico
FROM asignatura 
INNER JOIN pensum_programa_academico ON asignatura.id_asignatura = pensum_programa_academico.fk_id_asignatura
WHERE pensum_programa_academico.fk_id_programa_academico = '1'

-- Ver mis asignaturas docente
SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos, grupo.numero_grupo, grupo.id_docente_asignado
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON grupo.fk_id_curso = curso.id
WHERE grupo.id_docente_asignado = "987654321";

-- Ver mis asignaturas estudiante
SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
FROM historial_academico
INNER JOIN grupo ON historial_academico.fk_id_grupo = grupo.id
INNER JOIN curso ON grupo.fk_id_curso = curso.id
INNER JOIN asignatura ON asignatura.id_asignatura = curso.fk_id_asignatura
WHERE historial_academico.fk_id_estudiante = "123456789";


-- Ver información de MIS estudiantes (Vista docente)
SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos, usuario.correo_electronico, usuario.telefono
FROM usuario
INNER JOIN historial_academico ON usuario.id_usuario = fk_id_estudiante
INNER JOIN grupo ON grupo.id = historial_academico.fk_id_grupo
WHERE grupo.id_docente_asignado = "987654321";


-- Consulta para obtener el horario
  -- NO ESTOY TAN SEGURA SI DEBE SER ID_EDIFICIO, ID_SALON O SIMPLEMENTE NOMBRE 
    -- Horario docente
      SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo AS grupo, 
      clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana AS dia, ubicacion_clase.id_edificio,
      ubicacion_clase.id_salon, usuario.nombres AS nombres_docente, usuario.apellidos AS apellidos_docente
      FROM asignatura 
      INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
      INNER JOIN grupo ON grupo.fk_id_curso = curso.id
      INNER JOIN horario_clase ON horario_clase.fk_id_grupo = grupo.id
      INNER JOIN clase_dia ON clase_dia.id_clase_dia = horario_clase.fk_id_clase_dia
      INNER JOIN clase ON clase.id_clase = clase_dia.fk_id_clase
      INNER JOIN ubicacion_clase ON ubicacion_clase.id_ubicacion_clase = horario_clase.fk_id_ubicacion_clase  
      INNER join dia_semana ON dia_semana.id_dia_semana = clase_dia.fk_id_dia_semana
      INNER JOIN usuario ON usuario.id_usuario = grupo.id_docente_asignado
      WHERE grupo.id_docente_asignado = "12345";

    -- Horario estudiante (Falta hacer mas pruebas)
      SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo AS grupo, 
      clase.hora_inicio, clase.hora_final, dia_semana.nombre_dia_semana AS dia, ubicacion_clase.id_edificio,
      ubicacion_clase.id_salon, usuario.nombres AS nombres_docente, usuario.apellidos AS apellidos_docente
      FROM asignatura 
      INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
      INNER JOIN grupo ON grupo.fk_id_curso = curso.id
      INNER JOIN historial_academico ON historial_academico.fk_id_grupo = grupo.id
      INNER JOIN horario_clase ON horario_clase.fk_id_grupo = grupo.id
      INNER JOIN clase_dia ON clase_dia.id_clase_dia = horario_clase.fk_id_clase_dia
      INNER JOIN clase ON clase.id_clase = clase_dia.fk_id_clase
      INNER JOIN ubicacion_clase ON ubicacion_clase.id_ubicacion_clase = horario_clase.fk_id_ubicacion_clase  
      INNER join dia_semana ON dia_semana.id_dia_semana = clase_dia.fk_id_dia_semana
      INNER JOIN usuario ON usuario.id_usuario = grupo.id_docente_asignado
      WHERE historial_academico.fk_id_estudiante = "123456789";

-- Crear curso de extension (se usa la tabla de asignaturas)
    -- Lo unico que cambia es que en num_creditos guardará costo, no tendria prerrequisitos


-- Ver curso de extension desde rol administrativo (Cuando se busca, la informacion es resumida)
  --Por Codigo (en el docente no inclute asignatura.programa_academico)
    SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
    FROM asignatura 
    WHERE asignatura.id_asignatura LIKE "IS8%"
    ORDER BY id_asignatura ASC;

  --Por Nombre
    SELECT asignatura.id_asignatura, asignatura.nombre, asignatura.num_creditos
    FROM asignatura 
    WHERE asignatura.nombre LIKE "Labora%"
    ORDER BY nombre ASC;

-- Gestionar notas desde rol docente 
SELECT asignatura.id_asignatura, asignatura.nombre, grupo.numero_grupo, grupo.id_docente_asignado
FROM asignatura 
INNER JOIN curso ON asignatura.id_asignatura = curso.fk_id_asignatura
INNER JOIN grupo ON grupo.fk_id_curso = curso.id
WHERE grupo.id_docente_asignado = "987654321";

-------------------------------------------------------- REVISADAS PERO NO PROBADAS --------------------------------------------------------

-- 1. creditos matriculados por un estudiante en un periodo académico
SELECT SUM(a.num_creditos) AS total_creditos_matriculados
FROM nota_estudiante_asignatura_matriculada AS n
INNER JOIN matricula_academica AS m ON n.fk_id_matricula_academica = m.id_matricula_academica
INNER JOIN oferta_academica AS o ON m.fk_id_oferta_academica = o.id_oferta_academica
INNER JOIN asignatura AS a ON n.fk_id_asignatura = a.id_asignatura
WHERE m.fk_id_estudiante = <id_estudiante>
  AND o.fk_id_programa_academico = <id_programa_academico>
  AND o.id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = <anio> AND id_periodo_tiempo = <id_periodo_tiempo>
  );

-- 2. ubicación semestral de un estudiante
SELECT ROUND(c.total_creditos_aprobados / p.total_creditos, 2) AS ratio_creditos
FROM creditos_aprobados_estudiante_programa_academico AS c
INNER JOIN programa_academico AS p ON c.id_programa_academico = p.id_programa_academico
WHERE c.id_estudiante = <id_estudiante> AND c.id_programa_academico = <id_programa_academico>;

-- 3. último periodo académico que matriculó un estudiante
SELECT ap.anio, pt.id_periodo_tiempo AS periodo
FROM matricula_academica AS ma
INNER JOIN oferta_academica AS oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
INNER JOIN periodo_tiempo AS pt ON ap.id_periodo_tiempo = pt.id_periodo_tiempo
WHERE ma.fk_id_estudiante = <id_estudiante>
ORDER BY ap.anio DESC, pt.id_periodo_tiempo DESC
LIMIT 1;

-- 4. total de estudiantes matriculados en un periodo académico
SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
WHERE oa.fk_id_anio_periodo_academico = (
    SELECT id_anio_periodo_academico
    FROM anio_periodo_academico
    WHERE anio = <anio> AND id_periodo_tiempo = <id_periodo_tiempo>
  )

-- 5. total de estudiantes matriculados en un programa académico
SELECT COUNT(DISTINCT m.fk_id_estudiante) AS total_estudiantes
FROM matricula_academica AS m
INNER JOIN oferta_academica AS oa ON m.fk_id_oferta_academica = oa.id_oferta_academica
INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
WHERE ap.anio = <anio> AND ap.id_periodo_tiempo = <id_periodo_tiempo> AND oa.fk_id_programa_academico = <id_programa_academico>; 

-------------------------------------------------------- REVISADAS Y PROBADAS --------------------------------------------------------



-------------------------------------------------------- PENDIENTES --------------------------------------------------------
--1. Módulo de notas detallado y personalizable en cuanto a porcentajes
--2. Consulta que retorne el promedio de un estudiante en un programa academico en un periodo académico
--3. Consulta que retorne el promedio global de un estudiante en un programa academico
--4. Habilitaciones 
--5. Cancelaciones 