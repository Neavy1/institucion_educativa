import {
  metodos,
  type Iconsultas,
  type IinsertarNombreTablaEnConsultaParametros
} from '../interfaces'

export const obtenerConsulta = ({
  numeroConsulta
}: IinsertarNombreTablaEnConsultaParametros): string =>
  consultas[numeroConsulta].consulta

const consultas: Iconsultas = {
  // 1. Módulo de inicio
  //? 1. Lista de programas académicos() => TODO de tabla programa_academico
  1: {
    ruta: '/programas_academicos/',
    metodo: metodos.get,
    parametros: [],
    consulta: 'SELECT * FROM programa_academico;'
  },
  //? 2. Malla curricular de cada programa(id_programa_academico) => todos los id_asignatura de tabla pensum_programa_academico
  2: {
    ruta: '/asignaturas_programa_academico/:idProgramaAcademico/',
    metodo: metodos.get,
    parametros: ['idProgramaAcademico'],
    consulta: `SELECT asignatura.*
        FROM pensum_programa_academico ppa
        INNER JOIN programa_academico ON ppa.fk_id_programa_academico = programa_academico.id_programa_academico
        INNER JOIN asignatura ON ppa.fk_id_asignatura = asignatura.id_asignatura
        WHERE ppa.fk_id_programa_academico = ?`
  },
  //? 3. Asignaturas y cursos de extensión + detalle() => TODO de tabla asignatura
  3: {
    ruta: '/asignaturas_y_cursos/',
    // metodo: metodos.,
    parametros: [],
    consulta: 'SELECT * FROM asignatura'
  },
  //? 4. Lista de profesores con su nombre, apellido, departamento y foto de perfil(lista )
  4: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos, usuario.url_foto, detalle_docente.fk_id_departamento
    FROM usuario
    INNER JOIN detalle_docente ON usuario.id_usuario = detalle_docente.id_docente
    WHERE usuario.id_usuario = detalle_docente.id_docente`
  },
  // 2. Módulo de Login
  //? Con el número de cédula y el rol (dado por el endpoint desde donde intenta acceder), consultar si el usuario existe, y si tiene ese rol asignado en la tabla asignacion_roles. Si es así, retornar el hash, la salt y validar la contraseña en el back. //? comprobar en el backend si el usuario existe, si tiene ese rol asignado en la tabla asignacion_roles
  5: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT usuario.id_usuario, usuario.contrasena_salt, usuario.contrasena_hash, asignacion_roles.fk_id_rol
        FROM usuario
        INNER JOIN asignacion_roles ON usuario.id_usuario =     asignacion_roles.fk_id_usuario
        WHERE asignacion_roles.fk_id_usuario = ?
        AND asignacion_roles.fk_id_rol = ?`
  },
  // 3. Módulo estudiante
  //? 1. Ver los cursos en los que está matriculado y su horario, ver lista de asignaturas matriculadas (ambas cosas se miran en la tabla grupo). ver los programas académicos en los que está registrado, --- la malla curriculado --- y las ---asignaturas aprobadas, matriculadas y no aprobadas --- (nota_estudiante_asignatura_matriculada), ver notas parciales (historial_academico) y notas finales (nota_estudiante_asignatura_matriculada), información de perfil (usuario y detalle), cambiar contraseña
  6: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT id_anio_periodo_academico
        FROM anio_periodo_academico
        JOIN institucion_educativa ON anio_periodo_academico.anio = institucion_educativa.anio_vigente
        AND anio_periodo_academico.fk_id_periodo_academico = institucion_educativa.periodo_academico_vigente;`
  },
  //? 2. Lista de ofertas académicas de un estudiante(id_estudiante, anio, id_periodo_academico)
  7: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT
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
        ma.fk_id_estudiante = ?
        AND oa.fk_id_anio_periodo_academico = (
        SELECT id_anio_periodo_academico
        FROM anio_periodo_academico
        WHERE anio = ? AND fk_id_periodo_academico = ?
        );`
  },
  //? 3. Historial del estudiante en todos sus grupos de una anio y id_periodo_academico(id_estudiante, anio, id_periodo_academico)
  8: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT
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
        WHERE historial_academico.fk_id_estudiante = ? 
        AND oferta_academica.fk_id_anio_periodo_academico IN (
        SELECT id_anio_periodo_academico
        FROM anio_periodo_academico
        WHERE anio = ? AND fk_id_periodo_academico = ?
);`
  },
  //? 4. Historial del estudiante en TODA su historia(id_estudiante)
  //! Es mejor dejarlo para post entrega :v
  9: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT
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
        WHERE historial_academico.fk_id_estudiante = ?;`
  },
  //? 5. Obtener la matrícula académica de un estudiante(id_estudiante, id_oferta_academica)
  10: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT id_matricula_academica
        FROM matricula_academica
        WHERE fk_id_estudiante = ? AND fk_id_oferta_academica = ?;`
  },
  //? 6. Historial de notas del semestre(id_estudiante, id_oferta_academica)
  11: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT a.id_asignatura, a.nombre, n.                nota_final_estudiante_asignatura
        FROM nota_estudiante_asignatura_matriculada n
        JOIN asignatura a ON n.fk_id_asignatura = a.id_asignatura
        JOIN matricula_academica ma ON n.fk_id_matricula_academica = ma.id_matricula_academica
        WHERE ma.fk_id_estudiante = ? AND ma.fk_id_oferta_academica = ?;`
  },
  //? 7. Obtener información de un estudiante
  12: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT usuario.*, detalle_estudiante.*
        FROM usuario, detalle_estudiante
        WHERE usuario.id_usuario = ? AND detalle_estudiante.id_estudiante = ?;`
  },
  //? 8. Cambiar contraseña usuario (id_usuario, nueva_contrasena_salt, nueva_contrasena_hash)
  13: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `UPDATE usuario
        SET contrasena_salt = 'nueva_contrasena_salt',
        contrasena_hash = 'nueva_contrasena_hash'
        WHERE id_usuario = 1;`
  },
  //? 9. Créditos matriculados por un estudiante en un periodo académico y en un programa académico(d_estudiante, id_programa_academico, anio, id_periodo_tiempo)
  14: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT SUM(a.num_creditos) AS     total_creditos_matriculados
        FROM nota_estudiante_asignatura_matriculada AS n
        INNER JOIN matricula_academica AS m ON n.fk_id_matricula_academica = m.id_matricula_academica
        INNER JOIN oferta_academica AS o ON m.fk_id_oferta_academica = o.id_oferta_academica
        INNER JOIN asignatura AS a ON n.fk_id_asignatura = a.id_asignatura
        WHERE m.fk_id_estudiante = ?
        AND o.fk_id_programa_academico = ?
        AND o.fk_id_anio_periodo_academico = (
        SELECT id_anio_periodo_academico
        FROM anio_periodo_academico
        WHERE anio = ? AND fk_id_periodo_academico = ?
  );`
  },
  //? 10. Ubicación semestral de un estudiante en un programa académico(id_estudiante, id_oferta_academica)
  15: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT subquery.creditos_aprobados, subquery.creditos_totales, ROUND(subquery.creditos_aprobados/  subquery.creditos_totales * 100, 2) AS ratio_aprobado
      FROM (
      SELECT SUM(asignatura.num_creditos) AS creditos_aprobados, pa.total_creditos AS creditos_totales
      FROM asignaturas_aprobadas_estudiante_programa_academico AS aaepa
      INNER JOIN asignatura ON aaepa.fk_id_asignatura = asignatura.id_asignatura
      INNER JOIN oferta_academica oa ON aaepa.fk_id_oferta_academica = oa.id_oferta_academica
      INNER JOIN programa_academico pa ON oa.fk_id_programa_academico = pa.id_programa_academico
      WHERE aaepa.fk_id_estudiante = ? 
      AND aaepa.fk_id_oferta_academica = ?
    ) subquery;`
  },
  //? 11. Último periodo académico que matriculó un estudiante(id_estudiante)
  16: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT ap.anio, ap.fk_id_periodo_academico AS periodo_academico
      FROM matricula_academica AS ma
      INNER JOIN oferta_academica AS oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
      INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
      WHERE ma.fk_id_estudiante = ?
      ORDER BY ap.anio DESC, ap.fk_id_periodo_academico DESC
      LIMIT 1;`
  },
  //? 12. Registro nota final estudiante en un grupo(id_estudiante, id_grupo) TODO: Esta función se va a eliminar en favor de la 13+1
  17: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `INSERT INTO    nota_estudiante_asignatura_matriculada       (fk_id_matricula_academica, fk_id_asignatura, nota_final_estudiante_asignatura)
      SELECT ma.id_matricula_academica, curso.fk_id_asignatura, ((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4) AS promedio
      FROM historial_academico ha
      INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
      INNER JOIN curso ON grupo.fk_id_curso = curso.id
      INNER JOIN matricula_academica ma ON ha.fk_id_estudiante = ma.fk_id_estudiante
      WHERE ha.id in (
        SELECT id
        FROM historial_academico
        WHERE ha.fk_id_estudiante = ?
        AND ha.fk_id_grupo = ?
      )
      ON DUPLICATE KEY UPDATE nota_final_estudiante_asignatura = (ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4;`
  },
  //? 13. Registrar como aprobada una asignatura por un estudiante si su nota en el grupo es >= 3(id_estudiante, id_grupo)
  18: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `INSERT INTO asignaturas_aprobadas_estudiante_programa_academico (fk_id_estudiante, fk_id_oferta_academica, fk_id_asignatura, nota_final_estudiante_asignatura)
    SELECT id_estudiante, id_oferta_academica, id_asignatura, nota_asignatura
    FROM (
    SELECT ha.fk_id_estudiante AS id_estudiante, oa.id_oferta_academica AS id_oferta_academica, curso.fk_id_asignatura AS id_asignatura, ROUND((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4, 1) AS nota_asignatura
    FROM historial_academico ha
    INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
    INNER JOIN curso ON grupo.fk_id_curso = curso.id
    INNER JOIN oferta_academica oa ON curso.fk_id_oferta_academica = oa.id_oferta_academica
    WHERE ha.fk_id_estudiante = ?
      AND ha.fk_id_grupo = ?
  ) AS subquery
  HAVING nota_asignatura >= ?;`
  },
  //? 14. Promedio de un estudiante en una oferta academica(id_estudiante, id_oferta_academica) //! Hay que probarlo con más datos cuando los estudiantes tengan más notas
  19: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT AVG(ROUND((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4, 1)) AS promedio_semestral
    FROM historial_academico ha
    INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
    INNER JOIN curso ON grupo.fk_id_curso = curso.id
    INNER JOIN oferta_academica oa ON curso.fk_id_oferta_academica = oa.id_oferta_academica
    WHERE ha.fk_id_estudiante = ?
    AND curso.fk_id_oferta_academica = ?;
  */`
  },
  //? 4. Lista de profesores + detalle(id_usuario) => todos los id_usuario de tabla asignacion_roles where rol == 2 => lista docentes
  20: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT usuario.*, detalle_estudiante.*
    FROM usuario, detalle_estudiante
    WHERE usuario.id_usuario = ? AND detalle_estudiante.id_estudiante = ?;`
  },
  // 2. Módulo de Docente
  //? 1. Obtener información de un docente
  21: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT usuario.*, detalle_docente.*
    FROM usuario, detalle_docente
    WHERE usuario.id_usuario = ? AND detalle_docente.id_docente = ?`
  },
  //? 2. Ver las asignaturas que enseña un docente(id_docente)
  22: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT asignatura.*
    FROM docente_asignatura
    INNER JOIN asignatura ON docente_asignatura.fk_id_asignatura = asignatura.id_asignatura
    WHERE docente_asignatura.fk_id_docente = ?;`
  },
  //? 3. Ver horario de un docente(id_docente, anio, id_periodo_academico)
  23: {
    ruta: '',
    // metodo: metodos.,
    parametros: [],
    consulta: `SELECT
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
    WHERE grupo.fk_id_docente_asignado = ?
    AND anio_periodo_academico.anio = ? 
    AND anio_periodo_academico.fk_id_periodo_academico= ?
    );`
  }
}
