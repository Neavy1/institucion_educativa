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
  `fk_id_asignatura` int NOT NULL,
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

CREATE UNIQUE INDEX `clase_index_1` ON `clase` (`hora_inicio`, `hora_final`);

CREATE UNIQUE INDEX `clase_dia_index_2` ON `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`);

CREATE UNIQUE INDEX `oferta_academica_index_3` ON `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `matricula_academica_index_4` ON `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `curso_index_5` ON `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `grupo_index_6` ON `grupo` (`fk_id_curso`, `numero_grupo`);

CREATE UNIQUE INDEX `horario_clase_index_7` ON `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`);

CREATE UNIQUE INDEX `horario_clase_index_8` ON `horario_clase` (`fk_id_clase_dia`, `fk_id_ubicacion_clase`);

CREATE UNIQUE INDEX `historial_academico_index_9` ON `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `prerequisitos_asignatura_index_10` ON `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`);

CREATE UNIQUE INDEX `rol_permiso_index_11` ON `rol_permiso` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `asignacion_roles_index_12` ON `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`);

CREATE UNIQUE INDEX `docente_asignatura_index_13` ON `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `pensum_programa_academico_index_14` ON `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `detalle_administrativo_cargo_administrativo_index_15` ON `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`);

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
