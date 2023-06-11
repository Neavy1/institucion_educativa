CREATE DATABASE IF NOT EXISTS institucion_educativa;

USE institucion_educativa;

CREATE TABLE `institucion_educativa` (
  `id_institucion_educativa` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_institucion_educativa` varchar(100) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  `fk_id_rector` int NOT NULL,
  `anio_vigente` int NOT NULL,
  `periodo_academico_vigente` int NOT NULL
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
  `contrasena_hash` varchar(100) NOT NULL,
  `url_foto` varchar(100)
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
  `max_estudiantes` int NOT NULL,
  `curso_extension` boolean,
  `descripcion` varchar(255),
  `intensidad_horaria` int,
  `costo` int
);

CREATE TABLE `dia_semana` (
  `id_dia_semana` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_dia_semana` varchar(20) NOT NULL
);

CREATE TABLE `clase` (
  `id_clase` int PRIMARY KEY AUTO_INCREMENT,
  `hora_inicio` int NOT NULL,
  `duracion` int NOT NULL
);

CREATE TABLE `clase_dia` (
  `id_clase_dia` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_dia_semana` int NOT NULL,
  `fk_id_clase` int NOT NULL
);

CREATE TABLE `ubicacion_clase` (
  `id_ubicacion_clase` int PRIMARY KEY AUTO_INCREMENT,
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
  `fk_id_docente_asignado` int NOT NULL
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
  `nota_1` float,
  `nota_2` float,
  `nota_3` float,
  `nota_4` float
);

CREATE TABLE `nota_estudiante_asignatura_matriculada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_matricula_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL,
  `nota_final_estudiante_asignatura` float
);

CREATE TABLE `asignaturas_aprobadas_estudiante_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_estudiante` int NOT NULL,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL,
  `nota_final_estudiante_asignatura` float NOT NULL
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



CREATE UNIQUE INDEX `anio_periodo_academico_index_0` ON `anio_periodo_academico` (`anio`, `fk_id_periodo_academico`);

CREATE UNIQUE INDEX `clase_index_1` ON `clase` (`hora_inicio`, `duracion`);

CREATE UNIQUE INDEX `clase_dia_index_2` ON `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`);

CREATE UNIQUE INDEX `oferta_academica_index_3` ON `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `matricula_academica_index_4` ON `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `curso_index_5` ON `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `grupo_index_6` ON `grupo` (`fk_id_curso`, `numero_grupo`);

CREATE UNIQUE INDEX `horario_clase_index_7` ON `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`);

CREATE UNIQUE INDEX `horario_clase_index_8` ON `horario_clase` (`fk_id_clase_dia`, `fk_id_ubicacion_clase`);

CREATE UNIQUE INDEX `historial_academico_index_9` ON `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `nota_estudiante_asignatura_matriculada_index_10` ON `nota_estudiante_asignatura_matriculada` (`fk_id_matricula_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `asignaturas_aprobadas_estudiante_programa_academico_index_11` ON `asignaturas_aprobadas_estudiante_programa_academico` (`fk_id_estudiante`, `fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `prerequisitos_asignatura_index_12` ON `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`);

CREATE UNIQUE INDEX `rol_permiso_index_13` ON `rol_permiso` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `asignacion_roles_index_14` ON `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`);

CREATE UNIQUE INDEX `docente_asignatura_index_15` ON `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `pensum_programa_academico_index_16` ON `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `detalle_administrativo_cargo_administrativo_index_17` ON `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`);



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

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_clase`) REFERENCES `clase` (`id_clase`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_anio_periodo_academico`) REFERENCES `anio_periodo_academico` (`id_anio_periodo_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_curso`) REFERENCES `curso` (`id`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_docente_asignado`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_clase_dia`) REFERENCES `clase_dia` (`id_clase_dia`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_ubicacion_clase`) REFERENCES `ubicacion_clase` (`id_ubicacion_clase`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_matricula_academica`) REFERENCES `matricula_academica` (`id_matricula_academica`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `asignaturas_aprobadas_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `asignaturas_aprobadas_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `asignaturas_aprobadas_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

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


--
-- Volcado de datos para la tabla `sexo`
--

INSERT INTO `sexo` (`nombre_sexo`) VALUES
('Masculino'),
('Femenino');

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `sexo`, `nombres`, `apellidos`, `correo_electronico`, `telefono`, `contrasena_hash`, `url_foto`) VALUES
(1, 1, 'Luis Fernando ', 'Gaviria Trujillo', 'gaviria@correo.com', '123', '123', NULL),
(2, 1, 'Alexander', 'Molina Cabrera', 'decanoingenierias@utp.edu.co', '123', '123', NULL),
(3, 1, 'Juan Pablo', 'Trujillo Lemus', 'jtrujillo@utp.edu.co', '123', '123', NULL),
(4, 1, 'Enrique Demesio', 'Arias Castaño', 'decanaturabellasartes@utp.edu.co', '123', '123', NULL),
(5, 2, 'Cecilia Luca', 'Escobar Vekeman', 'decaeducacion@utp.edu.co', '123', '123', NULL),
(6, 1, 'Wilson', 'Arenas Valencia', 'warenas@utp.edu.co', '123', '123', NULL),
(111, 1, 'Edsger ', 'Dijkstra', 'eDijkstra@utp.edu.co', '111', '111', NULL),
(222, 1, 'Eduardo', 'Sáenz de Cabezón', 'derivando@utp.edu.co', '222', '222', NULL),
(333, 1, 'Jose Luis', 'Crespo Cepeda', 'quantumfracture@utp.edu.co', '333', '333', NULL),
(444, 1, 'Javier', 'Santaolalla', 'dateunvoltio@utp.edu.co', '444', '444', 'dmfkifj', NULL),
(777, 1, 'Ludwig', 'Von Bertalanffy', 'ludwig@utp.edu.co', '777', '777', NULL),
(6688, 1, 'Richard', 'Dorf', 'dorf@utp.edu.co', '6688', '6688', NULL),
(999, 1, 'Alan', 'Turing', 'turing@utp.edu.co', '999', '999', NULL),
(1010, 1, 'Bill', 'Gates', 'bgates@utp.edu.co', '1010', '1010', NULL),
(1111, 1, 'Thomas', 'Bayes', 'tbayes@utp.edu.co', '1111', '1111', NULL),
(1212, 1, 'Grady', 'Booch', 'gbooch@utp.edu.co', '1212', '1212', NULL),
(1314, 1, 'Thomas', 'Floyd', 'floyd@utp.edu.co', '1314', '1314', NULL),
(123, 2, 'Lady ', 'Gaga', 'bbymonster@utp.edu.co', '911', '123', NULL),
(124, 1, 'Christopher', 'Bang', 'bangchan@utp.edu.co', '124', '124', NULL),
(125, 2, 'Perry', 'Edwards', 'perry@utp.edu.co', '125', '125', NULL),
(126, 1, 'Sam', 'Smith', 'sams@utp.edu.co', '126', '126', NULL),
(127, 2, 'Ariana', 'Grande', 'ariana@utp.edu.co', '127', '127', NULL),
(456, 1, 'Harry', 'Styles', 'hstyles@utp.edu.co', '456', '456', NULL),
(457, 1, 'Luke', 'Hemmings', 'luke@utp.edu.co', '457', '457', NULL),
(458, 2, 'Billie', 'Eilish', 'b.eilish@utp.edu.co', '458', '458', NULL),
(459, 1, 'Rami', 'Malek', 'rami@utp.edu.co', '459', '459', NULL),
(789, 1, 'Elon ', 'Musk', 'tesla@utp.edu.co', '789', '789', NULL),
(790, 2, 'Dua', 'Lipa', 'dualipa@utp.edu.co', '790', '790', NULL),
(791, 1, 'Will', 'Smith', 'wsmith@utp.edu.co', '791', '791', NULL),
(792, 2, 'Selena', 'Gomez', 'selena@utp.edu.co', '792', '792', NULL),
(12345, 2, 'Maria Camila', 'Ramirez', 'm.ramirez8@utp.edu.co', '3333335', '12345', NULL);
COMMIT;


--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`id_direccion`, `direccion`, `barrio`, `ciudad`, `departamento`) VALUES
(111, 'Carrera 1 Calle 1-1', 'Un barrio', 'Róterdam', 'Países Bajos'),
(222, 'Carrera 2 Calle 2-2', 'Un barrio', 'Logroño', 'España'),
(333, 'Carrera 3 Calle 3-3', 'Un barrio', 'Madrid', 'España'),
(444, 'Carrera 4 Calle 4-4', 'Un barrio', 'Burgos', 'España'),
(6688, 'Carrera 6 Calle 6-8', 'Un barrio', 'California', 'Estados Unidos'),
(777, 'Carrera 7 Calle 7-7', 'Un barrio', 'Viena', 'Austria'),
(999, 'Carrera 9 Calle 9-9', 'Un barrio', 'Londres', 'Reino Unido'),
(1010, 'Carrera 10 Calle 10-10', 'Un barrio', 'Washington', 'Estados Unidos'),
(1111, 'Carrera 11 Calle 11-11', 'Un barrio', 'Londres', 'Reino Unido'),
(1212, 'Carrera 12 Calle 12-12', 'Un barrio', 'California', 'Estados Unidos'),
(1314, 'Carrera 13 Calle 13-14', 'Un barrio', 'California', 'Estados Unidos'),
(123, 'Carrera 1 Calle 2-3', 'Un barrio ', 'Nueva York', 'Estados Unidos'),
(124, 'Carrera 1 Calle 2-4', 'Un barrio ', 'Seúl', 'Corea del Sur'),
(125, 'Carrera 1 Calle 2-5', 'Un barrio ', 'South Shields', 'Reino Unido'),
(126, 'Carrera 1 Calle 2-6', 'Un barrio ', 'Londres', 'Reino Unido'),
(127, 'Carrera 1 Calle 2-7', 'Un barrio ', 'Florida', 'Estados Unidos'),
(456, 'Carrera 4 Calle 5-6', 'Un barrio ', 'Redditch', 'Reino Unido'),
(457, 'Carrera 4 Calle 5-7', 'Un barrio ', 'Sídney', 'Australia'),
(458, 'Carrera 4 Calle 5-8', 'Un barrio ', 'California', 'Estados Unidos'),
(459, 'Carrera 4 Calle 5-9', 'Un barrio ', 'California', 'Estados Unidos'),
(789, 'Carrera 7 Calle 8-9', 'Un barrio ', 'Pretoria', 'Sudáfrica'),
(790, 'Carrera 7 Calle 9-0', 'Un barrio ', 'Londres', 'Reino Unido'),
(791, 'Carrera 7 Calle 9-1', 'Un barrio ', 'Pensilvania', 'Estados Unidos'),
(792, 'Carrera 7 Calle 9-2', 'Un barrio ', 'Texas', 'Estados Unidos'),
(12345, 'UTP', 'Un barrio', 'Pereira', 'Risaralda');


--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`nombre_permiso`, `descripcion`) VALUES
('Permiso Administrativo 1', 'Administrativo con la capacidad de ver y editar infomación laboral'),
('Permiso Administrativo 2', 'Administrativo con la capacidad de ver, crear y editar asignaturas'),
('Permiso Docente', 'Usuario con capacidades limitadas en ciertos modulos'),
('Permiso Estudiante', 'Usuario con capacidades limitadas en ciertos modulos');

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`nombre_rol`) VALUES
('Administrativo'),
('Docente'),
('Estudiante');

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id`, `fk_id_rol`, `fk_id_permiso`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4);


--
-- Volcado de datos para la tabla `asignacion_roles`
--

INSERT INTO `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`) VALUES
(111, 2),
(222, 2),
(333, 2),
(444, 2),
(777, 2),
(6688, 2),
(999, 2),
(1010, 2),
(1111, 2),
(1212, 2),
(1314, 2),
(123, 3),
(124, 3),
(125, 3),
(126, 3),
(127, 3),
(456, 3),
(457, 3),
(458, 3),
(459, 3),
(789, 3),
(790, 3),
(791, 3),
(792, 3),
(12345, 1);

--
--
-- Volcado de datos para la tabla `tipo_contrato`
--

INSERT INTO `tipo_contrato` (`nombre_contrato`) VALUES
('Planta'),
('Transitorio'),
('Catedrático');


-- Volcado de datos para la tabla `estado_academico`
--

INSERT INTO `estado_academico` (`nombre_estado_academico`) VALUES
('Activo'),
('Inactivo');

--
-- Volcado de datos para la tabla `detalle_estudiante`
--

INSERT INTO `detalle_estudiante` (`id_estudiante`, `fk_id_estado_academico`) VALUES
(123, 1),
(456, 1),
(789, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 2),
(457, 1),
(458, 1),
(459, 1),
(790, 1),
(791, 2),
(792, 1);


--
-- Volcado de datos para la tabla `detalle_administrativo`
--

INSERT INTO `detalle_administrativo` (`id_administrativo`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(12345);


--
-- Volcado de datos para la tabla `cargo_administrativo`
--

INSERT INTO `cargo_administrativo` (`nombre_cargo_administrativo`, `descripcion_cargo_administrativo`) VALUES
('Rector', 'Persona encargada tomar decisiones sobre la institución educativa'),
('Director de facultad', 'Persona encargada tomar decisiones sobre determinada facultad'),
('Director de departamento', 'Persona encargada tomar decisiones sobre determinado departamento'),
('Director de programa academico', 'Persona encargada tomar decisiones sobre determinada programa academico'),
('Administrativo Registro y control', 'Persona que se encarga de la administración de asignaturas, cursos, estudiantes y docentes');


--
-- Volcado de datos para la tabla `detalle_administrativo_cargo_administrativo`
--
INSERT INTO `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 2);


--
-- Volcado de datos para la tabla `institucion_educativa`
--

INSERT INTO `institucion_educativa` (`nombre_institucion_educativa`, `fecha_fundacion`, `fk_id_rector`, `anio_vigente`, `periodo_academico_vigente`) VALUES
('Word Wise Institute', '2008-08-08', 1, 2023, 1);


--
-- Volcado de datos para la tabla `periodo_academico`
--

INSERT INTO `periodo_academico` (`nombre`, `descripcion`) VALUES
('Primer Semestre', 'Se refiere a los primeros 6 meses, que corresponde'),
('Segundo semestre', 'Se refiere a los últimos 6 meses, que corresponden'),
('Intersemestral 1', 'Corresponde al espacio entre el semestre 1 y 2'),
('Intersemestral 2', 'Corresponde al espacio entre el semestre 2 y 1 del');


--
-- Volcado de datos para la tabla `anio_periodo_academico`
--

INSERT INTO `anio_periodo_academico` (`anio`, `fk_id_periodo_academico`, `fk_id_institucion_educativa`, `fecha_matricula`, `fecha_inicio`, `fecha_final`) VALUES
(2023, 1, 1, '2023-01-04', '2023-02-06', '2023-06-27'),
(2023, 2, 1, '2023-07-19', '2023-06-01', '2023-12-08');


--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`nombre_facultad`, `ubicacion`, `fk_id_institucion_educativa`, `fk_id_director_facultad`) VALUES
('Facultad de Ingenierías', 'Edificio 3, entrada principal', 1, 2),
('Facultad de Ciencias Básicas', 'Edificio 1A, 4 piso entrada principal', 1, 3),
('Facultad de Bellas Artes y Humanidades', 'Edificio 12A, 5 piso, Entrada F', 1, 4),
('Facultad de Ciencias de la educación', 'Edificio 7A, 1 piso, Entrada ', 1, 5),
('Facultad de Ciencias Empresariales', 'Edificio 5, 1 piso, Entrada A', 1, 6);


--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`nombre_departamento`, `fk_id_facultad`, `fk_id_institucion_educativa`, `fk_id_jefe_departamento`) VALUES
('Departamento de Ingenierías', 1, 1, 1),
('Departamento de ciencias básicas', 2, 1, 2),
('Departamento de bellas artes y humanidades', 3, 1, 3),
('Departamento de ciencias de la educacion', 4, 1, 5),
('Departamento de ciencias empresariales', 5, 1, 6);


--
-- Volcado de datos para la tabla `asignatura`
--


INSERT INTO `asignatura` (`fk_id_departamento`, `nombre`, `num_creditos`, `max_estudiantes`, `descripcion`, `intensidad_horaria`, `costo`, `curso_extension`) VALUES
(1, 'Programación III', 3, 60, NULL, NULL, NULL, 0),
(2, 'Matematicas IV', 3, 120, NULL, NULL, NULL, 0),
(2, 'Fisica III', 4, 120, NULL, NULL, NULL, 0),
(2, 'Laboratorio de fisica III', 2, 60, NULL, NULL, NULL, 0),
(1, 'Fundamentos de electrónica', 3, 60, NULL, NULL, NULL, 0),
(1, 'Fundamentos de electrónica 2', 3, 60, NULL, NULL, NULL, 0),
(1, 'Teoria de sistemas', 2, 60, NULL, NULL, NULL, 0),
(1, 'Laboratorio de electronica', 2, 60, NULL, NULL, NULL, NULL),
(1, 'Gramaticas y lenguajes formales', 4, 100, NULL, NULL, NULL, NULL),
(1, 'Administracion de empresas', 3, 120, NULL, NULL, NULL, NULL),
(1, 'Estadistica', 2, 60, NULL, NULL, NULL, NULL),
(1, 'Programación IV', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Electrónica digital', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Laboratorio de electronica digital', 2, 60, NULL, NULL, NULL, NULL),
(2, 'Metodos numericos', 3, 120, NULL, NULL, NULL, NULL),
(1, 'Electrónica general', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Laboratorio de electronica general', 2, 60, NULL, NULL, NULL, NULL),
(1, 'Estadistica Ing. Física', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Electrónica lineal', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Mecanica de fluidos', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Programación II Ing.fisica', 3, 120, NULL, NULL, NULL, NULL),
(1, 'Termodinámica', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Metodos matemáticos para la física', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Laboratorio de electronica lineal', 2, 60, NULL, NULL, NULL, NULL),
(2, 'Metodos numericos y programación', 3, 120, NULL, NULL, NULL, NULL),
(1, 'Electromagnetismo I', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Fundamentos de mecánica', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Electiva Socio Humanística III', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Estadística y probabilidad', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Circuitos eléctricos I', 4, 60, NULL, NULL, NULL, NULL),
(1, 'Generación de energía eléctrica', 3, 120, NULL, NULL, NULL, NULL),
(1, 'Electromagnetismo II', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Manufactura I', 2, 120, NULL, NULL, NULL, NULL),
(1, 'Materiales de Ingeniería I', 2, 60, NULL, NULL, NULL, NULL),
(1, 'Dinámica', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Estadística general', 3, 60, NULL, NULL, NULL, NULL),
(2, 'Ecuaciones diferenciales', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Resistencia de materiales I', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Termonodinámica I', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Manufactura II', 2, 120, NULL, NULL, NULL, NULL),
(1, 'Teoría de maquinas y mecanismos', 4, 60, NULL, NULL, NULL, NULL),
(1, 'Dibujo de maquinas', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Materiales de ingeniería II', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Dibujo IV', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Técnicas de impresión', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Técnología de la imagen II', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Arte Latinoamericano', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Arte de la tierra', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Practica pedagogica II', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Psicología del desarrollo', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Dibujo y expresión', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Taller tridimensional', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Metodología de la investigación I', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Administración educacional', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Taller bidimensional I', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Práctica pedagogica III', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Medios de comunicación', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Didáctica de la filosofía II', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Psicología II', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Estética moderna II', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Empirismo', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Filosofía Antigua', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Seminario de investigación en el Aula', 5, 60, NULL, NULL, NULL, NULL),
(3, 'Filosofía de la educación', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Filosofía moderna', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Estética y filosofía del arte', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Psicoliguística', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Pronunciación inglesa II', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Inglés Intermedio Alto', 6, 60, NULL, NULL, NULL, NULL),
(3, 'Discurso académico I', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Gramática aavanzada', 4, 60, NULL, NULL, NULL, NULL),
(3, 'Sociolinguística', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Adquisión del lenguaje', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Cultura Anglófona I', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Discurso académico II', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Fundamentos dela investigación y practica pedagogica II', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Piano complementario II', 1, 60, NULL, NULL, NULL, NULL),
(3, 'Historia de la música universal II', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Lenguaje musical IV', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Enfoques pedagogicos', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Práctica coral IV', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Didáctica general', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Electiva instrumento', 1, 60, NULL, NULL, NULL, NULL),
(3, 'Guitarra funcional IV', 1, 60, NULL, NULL, NULL, NULL),
(3, 'TIC para la pedagogía musical III', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Administración Educacional', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Apoyos didácticos, tecnológicos y educativos', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Politicas educativas', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Fundamentos dela investigación y practica pedagogica III', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Piano complementario III', 1, 60, NULL, NULL, NULL, NULL),
(3, 'Historia de la música universal III', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Práctica coral V', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Lenguaje musical V', 2, 60, NULL, NULL, NULL, NULL),
(3, 'Guitarra funcional V', 1, 60, NULL, NULL, NULL, NULL),
(4, 'Seminario de políticas públicas y gestión educativa', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Historia de america latina', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Democracia y constitución política', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Didáctica deas ciencias sociales', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Entidades territoriales y legislación colombiana', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Investigación educativa I', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Seminario familia comunidad y escuela', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Competencias comunicativas II y TICs', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Procesos historicos de construcción de nación en Colombia', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Teoría política', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Seminario de territorios y territorialidades', 3, 60, NULL, NULL, NULL, NULL),
(3, 'Evaluación educativa', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Didáctica del lenguaje', 4, 60, NULL, NULL, NULL, NULL),
(4, 'Construcción y didáctica de las ciencias naturales', 4, 60, NULL, NULL, NULL, NULL),
(4, 'Usos pedagógicos', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Práctica pedagógica I', 8, 60, NULL, NULL, NULL, NULL),
(4, 'Investigación cuantitativa', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Construcción y didática de las ciencias sociales', 4, 60, NULL, NULL, NULL, NULL),
(4, 'Didáctica de las ciencias naturales', 4, 60, NULL, NULL, NULL, NULL),
(4, 'Usos pedagogicos de las TIC II', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Práctica pedagógica II', 8, 60, NULL, NULL, NULL, NULL),
(4, 'Electiva II EBP ', 1, 60, NULL, NULL, NULL, NULL),
(4, 'Administración educativa', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Fonética y fonología del español', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Literatura Amerindia', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Las TIC en el contexto educativo', 4, 60, NULL, NULL, NULL, NULL),
(4, 'Electiva II CL', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Morfología', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Literatura medieval', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Práctica pedagógica: Experiencias significativas', 5, 60, NULL, NULL, NULL, NULL),
(4, 'Literatura Latino Americana I ', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Laboratorio Sonoro', 1, 60, NULL, NULL, NULL, NULL),
(4, 'Radio', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Informática educativa II', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Teorías de la imagen', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Teorías del aprendizaje', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Práctica observacional', 5, 60, NULL, NULL, NULL, NULL),
(4, 'Laboratorio Audiovisual I', 1, 60, NULL, NULL, NULL, NULL),
(4, 'Cine', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Informática educativa III', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Didáctica general', 3, 60, NULL, NULL, NULL, NULL),
(4, 'Administración educativa', 2, 60, NULL, NULL, NULL, NULL),
(4, 'Electiva TC', 2, 60, NULL, NULL, NULL, NULL),
(2, 'Calculo multivariado', 4, 60, NULL, NULL, NULL, NULL),
(5, 'Economía', 3, 60, NULL, NULL, NULL, NULL),
(2, 'Fisica II', 4, 60, NULL, NULL, NULL, NULL),
(2, 'Laboratorio de fisica II', 2, 60, NULL, NULL, NULL, NULL),
(5, 'Sicología organizacional', 2, 60, NULL, NULL, NULL, NULL),
(5, 'Estadítica I', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Contabilidad de empresas', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Administración personal', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Estadística II', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Estática', 3, 60, NULL, NULL, NULL, NULL),
(5, 'Electivas de formación Socio-Humanística II', 4, 60, NULL, NULL, NULL, NULL),
(2, 'Ecuaciones diferenciales', 3, 60, NULL, NULL, NULL, NULL),
(1, 'Curso rápido de JavaScript', NULL, 120, 'Curso para aprender las bases de JavaScript, se requiere conocimientos básicos de programación', 40, 500000, 1);


--
-- Volcado de datos para la tabla `prerequisitos_asignatura`
--

INSERT INTO `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`) VALUES
(6, 140),
(13, 6),
(14, 8),
(12, 1),
(3, 140),
(4, 141);


--
-- Volcado de datos para la tabla `detalle_docente`
--

INSERT INTO `detalle_docente` (`id_docente`, `fk_id_departamento`, `url_hoja_de_vida`, `salario`, `fk_id_tipo_contrato`) VALUES
(111, 1, 'dijkstra.com', 7000000, 1),
(222, 1, 'derivando.com', 7000000, 1),
(333, 1, 'quantumfracture.com', 3000000, 3),
(444, 1, 'dateunvoltio.com', 5000000, 2),
(6688, 1, 'dorf.com', 7000000, 1),
(777, 1, 'Bertalanffy.com', 5000000, 2),
(999, 1, 'turing.com', 7000000, 1),
(1010, 1, 'billgates.com', 3000000, 3),
(1111, 1, 'bayes.com', 3000000, 3),
(1212, 1, 'booch.com', 5000000, 2),
(1314, 1, 'floyd.com', 7000000, 1);


--
-- Volcado de datos para la tabla `programa_academico`
--


INSERT INTO `programa_academico` (`fk_id_facultad`, `nombre`, `total_creditos`, `fk_id_director`) VALUES
(1, 'Ingeniería de Sistemas y Computación', 183, 1),
(1, 'Ingeniería Eléctrica', 174, 2),
(1, 'Ingeniería Física', 175, 3),
(1, 'Ingeniería Mecánica', 174, 2),
(3, 'Licenciatura en artes visuales', 167, 1),
(3, 'Licenciatura en filosofía', 164, 3),
(3, 'Licenciatura en Bilingüismo con Énfasis en Inglés', 152, 5),
(3, 'Licenciatura en Música', 185, 2),
(4, 'Licenciatura en Ciencias Sociales', 146, 1),
(4, 'Licenciatura en Educación Básica Primaria', 2, 6),
(4, 'Licenciatura en Literatura y Lengua Castellana', 159, 4),
(4, 'Licenciatura en Tecnología', 163, 1),
(5, 'Ingeniería Industrial', 176, 12345);


--
-- Volcado de datos para la tabla `pensum_programa_academico`
--


INSERT INTO `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 140),
(1, 141),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(2, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 2),
(2, 3),
(2, 4),
(2, 140),
(2, 141),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 2),
(3, 3),
(3, 4),
(3, 140),
(3, 141),
(4, 37),
(4, 38),
(4, 39),
(4, 40),
(4, 41),
(4, 42),
(4, 43),
(4, 2),
(4, 3),
(4, 4),
(4, 140),
(4, 141),
(5, 44),
(5, 45),
(5, 46),
(5, 47),
(5, 48),
(5, 49),
(5, 50),
(5, 51),
(5, 52),
(5, 53),
(5, 54),
(5, 55),
(5, 56),
(5, 57),
(6, 58),
(6, 59),
(6, 60),
(6, 61),
(6, 62),
(6, 63),
(6, 64),
(6, 65),
(6, 66),
(7, 67),
(7, 68),
(7, 69),
(7, 70),
(7, 71),
(7, 72),
(7, 73),
(7, 74),
(7, 75),
(7, 76),
(8, 77),
(8, 78),
(8, 79),
(8, 80),
(8, 81),
(8, 82),
(8, 83),
(8, 84),
(8, 85),
(8, 86),
(8, 87),
(8, 88),
(8, 89),
(8, 90),
(8, 91),
(8, 92),
(8, 93),
(8, 94),
(9, 95),
(9, 96),
(9, 97),
(9, 98),
(9, 99),
(9, 100),
(9, 101),
(9, 102),
(9, 103),
(9, 104),
(9, 105),
(9, 106),
(10, 107),
(10, 108),
(10, 109),
(10, 110),
(10, 111),
(10, 112),
(10, 113),
(10, 114),
(10, 115),
(10, 116),
(11, 117),
(11, 118),
(11, 119),
(11, 120),
(11, 121),
(11, 122),
(11, 123),
(11, 124),
(11, 125),
(12, 126),
(12, 127),
(12, 128),
(12, 129),
(12, 130),
(12, 131),
(12, 132),
(12, 133),
(12, 134),
(12, 135),
(12, 136),
(12, 137),
(13, 138),
(13, 139),
(13, 140),
(13, 141),
(13, 142),
(13, 143),
(13, 144),
(13, 145),
(13, 146),
(13, 147),
(13, 148),
(13, 2),
(13, 3),
(13, 4);

--
-- Volcado de datos para la tabla `docente_asignatura`
--

INSERT INTO `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`) VALUES
(111, 1),
(222, 2),
(333, 3),
(444, 4),
(6688, 6),
(6688, 8),
(777, 7),
(999, 9),
(1010, 10),
(1111, 11),
(1212, 12),
(1314, 13),
(1314, 14);


--
-- Volcado de datos para la tabla `oferta_academica`
--

INSERT INTO `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2),
(1, 3),
(2, 3),
(1, 4),
(2, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 7),
(1, 8),
(1, 9),
(2, 9),
(1, 10),
(2, 10),
(1, 11),
(2, 11),
(1, 12),
(2, 12),
(1, 13),
(2, 13);

--
-- Volcado de datos para la tabla `matricula_academica`
--

INSERT INTO `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`) VALUES
(1, 123),
(1, 124),
(1, 125),
(1, 126),
(1, 127),
(1, 456),
(1, 457),
(1, 458),
(1, 459),
(1, 789),
(1, 790),
(1, 791),
(1, 792);

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 150),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14);


--
-- Volcado de datos para la tabla `clase`
--
INSERT INTO `clase` (`hora_inicio`, `duracion`) VALUES
(7, 2),
(9, 2),
(11, 3),
(14, 2),
(16, 1),
(18, 3),
(20, 1);


--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`fk_id_curso`, `numero_grupo`, `fk_id_docente_asignado`) VALUES
(1, 1, 111),
(1, 2, 1212),
(2, 1, 222),
(2, 2, 222),
(3, 1, 333),
(4, 1, 444),
(7, 1, 777),
(6, 1, 6688),
(8, 1, 6688),
(9, 1, 999),
(9, 2, 999),
(10, 1, 1010),
(11, 1, 1111),
(12, 1, 1212),
(12, 2, 111),
(13, 1, 1314),
(14, 1, 1314),
(10, 2, 111);


--
-- Volcado de datos para la tabla `dia_semana`
--

INSERT INTO `dia_semana` (`nombre_dia_semana`) VALUES
('Lunes'),
('Martes'),
('Miercoles'),
('Jueves'),
('Viernes'),
('Sábado'),
('Domingo');


INSERT INTO `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(1, 7),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(1, 2),
(2, 6),
(3, 7),
(4, 7),
(5, 7),
(6, 4),
(1, 4),
(2, 4),
(3, 4),
(4, 3),
(5, 3),
(6, 3),
(1, 3),
(2, 3),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(2, 5),
(3, 5),
(5, 6),
(1, 5),
(3, 6),
(4, 6),
(5, 4);



INSERT INTO `ubicacion_clase` (`id_edificio`, `id_salon`, `nombre`, `descripcion`) VALUES
(1, 123, 'crie', ''),
(2, 234, 'hell', ''),
(3, 345, 'industrial', ''),
(4, 456, 'piscina', ''),
(5, 567, 'la concha de tu madre', '');

--
-- Volcado de datos para la tabla `horario_clase`
--

INSERT INTO `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`, `fk_id_ubicacion_clase`) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 3),
(2, 4, 4),
(3, 5, 5),
(3, 6, 1),
(4, 7, 3),
(4, 8, 3),
(5, 9, 4),
(5, 10, 5),
(5, 11, 1),
(6, 12, 2),
(7, 13, 3),
(7, 14, 4),
(8, 15, 5),
(8, 16, 1),
(9, 17, 2),
(10, 18, 3),
(10, 19, 4),
(10, 20, 5),
(11, 21, 1),
(11, 22, 2),
(11, 23, 3),
(12, 24, 4),
(12, 25, 5),
(13, 26, 1),
(13, 27, 2),
(14, 28, 3),
(14, 29, 2),
(15, 30, 2),
(15, 31, 1),
(16, 32, 2),
(16, 33, 3),
(17, 34, 4),
(18, 35, 5);

--
-- Volcado de datos para la tabla `historial_academico`
--

INSERT INTO `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`, `nota_1`, `nota_2`, `nota_3`, `nota_4`) 
VALUES
(2, 456, NULL, NULL, NULL, NULL),
(3, 456, NULL, NULL, NULL, NULL),
(5, 456, NULL, NULL, NULL, NULL),
(6, 456, NULL, NULL, NULL, NULL),
(8, 456, NULL, NULL, NULL, NULL),
(7, 456, NULL, NULL, NULL, NULL),
(9, 456, NULL, NULL, NULL, NULL),
(2, 457, NULL, NULL, NULL, NULL),
(3, 457, NULL, NULL, NULL, NULL),
(5, 457, NULL, NULL, NULL, NULL),
(6, 457, NULL, NULL, NULL, NULL),
(8, 457, NULL, NULL, NULL, NULL),
(7, 457, NULL, NULL, NULL, NULL),
(9, 457, NULL, NULL, NULL, NULL),
(2, 459, NULL, NULL, NULL, NULL),
(3, 459, NULL, NULL, NULL, NULL),
(5, 459, NULL, NULL, NULL, NULL),
(6, 459, NULL, NULL, NULL, NULL),
(8, 459, NULL, NULL, NULL, NULL),
(7, 459, NULL, NULL, NULL, NULL),
(9, 459, NULL, NULL, NULL, NULL),
(2, 790, NULL, NULL, NULL, NULL),
(3, 790, NULL, NULL, NULL, NULL),
(5, 790, NULL, NULL, NULL, NULL),
(6, 790, NULL, NULL, NULL, NULL),
(8, 790, NULL, NULL, NULL, NULL),
(7, 790, NULL, NULL, NULL, NULL),
(9, 790, NULL, NULL, NULL, NULL),
(1, 123, NULL, NULL, NULL, NULL),
(1, 126, NULL, NULL, NULL, NULL),
(10, 123, NULL, NULL, NULL, NULL),
(12, 123, NULL, NULL, NULL, NULL),
(13, 123, NULL, NULL, NULL, NULL),
(16, 123, NULL, NULL, NULL, NULL),
(17, 123, NULL, NULL, NULL, NULL),
(10, 124, NULL, NULL, NULL, NULL),
(12, 124, NULL, NULL, NULL, NULL),
(13, 124, NULL, NULL, NULL, NULL),
(14, 124, NULL, NULL, NULL, NULL),
(16, 124, NULL, NULL, NULL, NULL),
(17, 124, NULL, NULL, NULL, NULL);



-- Volcado de datos para la tabla `nota_estudiante_asignatura_matriculada`
--

INSERT INTO `nota_estudiante_asignatura_matriculada` (`fk_id_matricula_academica`, `fk_id_asignatura`, `nota_final_estudiante_asignatura`) VALUES
(1, 1, NULL),
(1, 10, NULL),
(1, 12, NULL),
(1, 13, NULL),
(1, 16, NULL),
(1, 17, NULL),
(2, 10, NULL),
(2, 12, NULL),
(2, 13, NULL),
(2, 14, NULL),
(2, 16, NULL),
(2, 17, NULL),
(4, 1, NULL),
(6, 1, NULL),
(6, 2, NULL),
(6, 3, NULL),
(6, 4, NULL),
(6, 6, NULL),
(6, 7, NULL),
(6, 8, NULL),
(7, 1, NULL),
(7, 2, NULL),
(7, 3, NULL),
(7, 4, NULL),
(7, 6, NULL),
(7, 7, NULL),
(7, 8, NULL),
(9, 1, NULL),
(9, 2, NULL),
(9, 3, NULL),
(9, 4, NULL),
(9, 6, NULL),
(9, 7, NULL),
(9, 8, NULL),
(10, 1, NULL),
(10, 2, NULL),
(10, 3, NULL),
(10, 4, NULL),
(10, 6, NULL),
(10, 7, NULL),
(10, 8, NULL);

-- 
-- Volcado de datos para la tabla `id_asignatura`
--

INSERT INTO `asignaturas_aprobadas_estudiante_programa_academico` (`fk_id_estudiante`, `fk_id_oferta_academica`, `fk_id_asignatura`, `nota_final_estudiante_asignatura`) VALUES
(790, 1, 11, 2.9),
(791, 1, 12, 3.0),
(792, 1, 13, 4.5);
