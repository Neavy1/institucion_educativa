import {
  metodos,
  type IconsultaRespuesta,
  type Iconsultas,
  type IobtenerRuta
} from '../interfaces'

const obtenerConsulta = (numeroConsulta: number): IconsultaRespuesta => {
  const consultaRespuesta: IconsultaRespuesta = {
    consulta: consultas[numeroConsulta].consulta,
    descripcion: consultas[numeroConsulta].descripcion ?? '',
    cantidadDeParametros: consultas[numeroConsulta].parametros.length
  }

  return consultaRespuesta
}

//! Esta función va para el Frontend
const obtenerRuta = ({
  numeroConsulta,
  arregloParametros
}: IobtenerRuta): string => {
  // rutaLectura = http://localhost:3000/api/lectura?numeroConsulta=1&parametro1=111&parametro2=222&parametro3=333
  // rutaLectura = http://localhost:3000/api/escritura?numeroConsulta=1&parametro1=111&parametro2=222&parametro3=333
  //TODO: importar endpoint base de las variables de entorno y ponerlo al inicio de la ruta
  let ruta = `?numeroConsulta=${numeroConsulta}`
  arregloParametros.forEach((parametro, indice) => {
    ruta += `&parametro${indice + 1}=${parametro}`
  })

  return ruta
}

export { obtenerConsulta, obtenerRuta }

export const consultas: Iconsultas = {
  //? 1. Módulo de inicio
  1: {
    metodo: metodos.get,
    parametros: [],
    consulta: 'SELECT * FROM programa_academico;',
    descripcion: 'Lista de programas académicos'
  },

  2: {
    metodo: metodos.get,
    parametros: ['idProgramaAcademico'],
    consulta: `SELECT asignatura.*
        FROM pensum_programa_academico ppa
        INNER JOIN programa_academico ON ppa.fk_id_programa_academico = programa_academico.id_programa_academico
        INNER JOIN asignatura ON ppa.fk_id_asignatura = asignatura.id_asignatura
        WHERE ppa.fk_id_programa_academico = ?`,
    descripcion: 'Todas las asignaturas de un programa académico'
  },

  3: {
    metodo: metodos.get,
    parametros: [],
    consulta: 'SELECT * FROM asignatura',
    descripcion: 'Todas las asignaturas y cursos de extensión'
  },

  4: {
    metodo: metodos.get,
    parametros: [],
    consulta: `SELECT usuario.id_usuario, usuario.nombres, usuario.apellidos, usuario.url_foto, detalle_docente.fk_id_departamento
    FROM usuario
    INNER JOIN detalle_docente ON usuario.id_usuario = detalle_docente.id_docente
    WHERE usuario.id_usuario = detalle_docente.id_docente`,
    descripcion:
      'Lista de profesores con su nombre, apellido, departamento y foto de perfil'
  },
  //? 2. Módulo de Login
  5: {
    metodo: metodos.get,
    parametros: ['idUsuario', 'idRol'],
    consulta: `SELECT u.sexo, u.nombres, u.apellidos, u.correo_electronico, u.telefono, u.url_foto, d.fk_id_estado_academico, dd.id_docente, dd.fk_id_departamento, dd.fk_id_tipo_contrato, da.id_administrativo
    FROM usuario u
    LEFT JOIN asignacion_roles ar ON u.id_usuario = ar.fk_id_usuario
    LEFT JOIN detalle_estudiante d ON u.id_usuario = d.id_estudiante AND ar.fk_id_rol = 1
    LEFT JOIN detalle_docente dd ON u.id_usuario = dd.id_docente AND ar.fk_id_rol = 2
    LEFT JOIN detalle_administrativo da ON u.id_usuario = da.id_administrativo AND ar.fk_id_rol = 3
    WHERE u.id_usuario = ? AND ar.fk_id_rol = ?;`,
    descripcion: 'Todos los datos del usuario accesibles para él'
  },

  //? 3. Módulo estudiante
  6: {
    metodo: metodos.get,
    parametros: [],
    consulta: `SELECT id_anio_periodo_academico
        FROM anio_periodo_academico
        JOIN institucion_educativa ON anio_periodo_academico.anio = institucion_educativa.anio_vigente
        AND anio_periodo_academico.fk_id_periodo_academico = institucion_educativa.periodo_academico_vigente;`,
    descripcion: 'id del anio + periodo academio'
  },

  7: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'anio', 'idPeriodoAcademico'],
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
        );`,
    descripcion: 'Lista de ofertas académicas de un estudiante'
  },

  8: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'anio', 'idPeriodoAcademico'],
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
);`,
    descripcion:
      'Historial del estudiante en todos sus grupos de una anio y periodo académico'
  },

  //! Es mejor dejarlo para después de la entrega :v
  9: {
    metodo: metodos.get,
    parametros: ['idEstudiante'],
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
        WHERE historial_academico.fk_id_estudiante = ?;`,
    descripcion: 'Historial del estudiante en TODA su historia'
  },

  10: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    consulta: `SELECT id_matricula_academica
        FROM matricula_academica
        WHERE fk_id_estudiante = ? AND fk_id_oferta_academica = ?;`,
    descripcion: 'id de la matrícula académica de un estudiante'
  },

  11: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    consulta: `SELECT a.id_asignatura, a.nombre, n.                nota_final_estudiante_asignatura
        FROM nota_estudiante_asignatura_matriculada n
        JOIN asignatura a ON n.fk_id_asignatura = a.id_asignatura
        JOIN matricula_academica ma ON n.fk_id_matricula_academica = ma.id_matricula_academica
        WHERE ma.fk_id_estudiante = ? AND ma.fk_id_oferta_academica = ?;`,
    descripcion: 'Historial de notas del semestre de un estudiante'
  },

  13: {
    metodo: metodos.post,
    parametros: ['nuevaContrasena', 'idUsuario'],
    consulta: `UPDATE usuario
        SET contrasena_hash = ?
        WHERE id_usuario = ?;`,
    descripcion: 'Cambiar contraseña usuario'
    // parametros: {
    //   "idUsuario": 123,
    //   "nuevaContrasena": "123"
    // }
  },

  14: {
    metodo: metodos.get,
    parametros: [
      'idEstudiante',
      'idProgramaAcademico',
      'anio',
      'idPeriodoAcademico'
    ],
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
  );`,
    descripcion:
      'Créditos matriculados por un estudiante en un periodo académico y en un programa académico'
  },

  15: {
    //! Esta vainda retorna los flotantes como strings
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    consulta: `SELECT subquery.creditos_aprobados, subquery.creditos_totales, ROUND(subquery.creditos_aprobados/  subquery.creditos_totales * 100, 2) AS ratio_aprobado
      FROM (
      SELECT SUM(asignatura.num_creditos) AS creditos_aprobados, pa.total_creditos AS creditos_totales
      FROM asignaturas_aprobadas_estudiante_programa_academico AS aaepa
      INNER JOIN asignatura ON aaepa.fk_id_asignatura = asignatura.id_asignatura
      INNER JOIN oferta_academica oa ON aaepa.fk_id_oferta_academica = oa.id_oferta_academica
      INNER JOIN programa_academico pa ON oa.fk_id_programa_academico = pa.id_programa_academico
      WHERE aaepa.fk_id_estudiante = ? 
      AND aaepa.fk_id_oferta_academica = ?
    ) subquery;`,
    descripcion: 'Ubicación semestral de un estudiante en un programa académico'
  },

  16: {
    metodo: metodos.get,
    parametros: ['idEstudiante'],
    consulta: `SELECT ap.anio, ap.fk_id_periodo_academico AS periodo_academico
      FROM matricula_academica AS ma
      INNER JOIN oferta_academica AS oa ON ma.fk_id_oferta_academica = oa.id_oferta_academica
      INNER JOIN anio_periodo_academico AS ap ON oa.fk_id_anio_periodo_academico = ap.id_anio_periodo_academico
      WHERE ma.fk_id_estudiante = ?
      ORDER BY ap.anio DESC, ap.fk_id_periodo_academico DESC
      LIMIT 1;`,
    descripcion: 'Último periodo académico que matriculó un estudiante'
  },

  //TODO: Esta función se va a eliminar en favor de la 18
  17: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idGrupo'],
    consulta: `INSERT INTO nota_estudiante_asignatura_matriculada (fk_id_matricula_academica, fk_id_asignatura, nota_final_estudiante_asignatura)
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
      ON DUPLICATE KEY UPDATE nota_final_estudiante_asignatura = (ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4;`,
    descripcion:
      'Registra la nota final estudiante en un grupo en la tabla de notas'
  },

  18: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idGrupo'],
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
  HAVING nota_asignatura >= 3;`,
    descripcion:
      'Registrar como aprobada una asignatura por un estudiante si su nota en el grupo es >= 3 en su lista de materias aprobadas en el programa académico correspondiente'
  },

  19: {
    //! Hay que probarlo con más datos cuando los estudiantes tengan más notas
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    consulta: `SELECT AVG(ROUND((ha.nota_1 + ha.nota_2 + ha.nota_3 + ha.nota_4) / 4, 1)) AS promedio_semestral
    FROM historial_academico ha
    INNER JOIN grupo ON ha.fk_id_grupo = grupo.id
    INNER JOIN curso ON grupo.fk_id_curso = curso.id
    INNER JOIN oferta_academica oa ON curso.fk_id_oferta_academica = oa.id_oferta_academica
    WHERE ha.fk_id_estudiante = ?
    AND curso.fk_id_oferta_academica = ?;`,
    descripcion: 'Promedio de un estudiante en una oferta academica'
  },

  //? 3. Módulo de Docente
  20: {
    metodo: metodos.get,
    parametros: ['idDocente'],
    consulta: `SELECT asignatura.*
    FROM docente_asignatura
    INNER JOIN asignatura ON docente_asignatura.fk_id_asignatura = asignatura.id_asignatura
    WHERE docente_asignatura.fk_id_docente = ?;`,
    descripcion: 'Lista de las asignaturas que enseña un docente'
  },
  21: {
    metodo: metodos.get,
    parametros: ['idDocente', 'anio', 'idPeriodoAcademico'],
    consulta: `SELECT grupo.id
    FROM grupo
    INNER JOIN curso ON grupo.fk_id_curso = curso.id
    INNER JOIN oferta_academica ON curso.fk_id_oferta_academica = oferta_academica.id_oferta_academica
    INNER JOIN anio_periodo_academico ON oferta_academica.fk_id_anio_periodo_academico = anio_periodo_academico.id_anio_periodo_academico
    WHERE grupo.fk_id_docente_asignado = ?
    AND anio_periodo_academico.anio = ? 
    AND anio_periodo_academico.fk_id_periodo_academico= ?`,
    descripcion:
      'Lista de grupos en los que enseña un docente en un periodo académico'
  },

  22: {
    metodo: metodos.get,
    parametros: ['idDocente', 'anio', 'idPeriodoAcademico'],
    consulta: `SELECT
    grupo.id,
    grupo.numero_grupo,
    asignatura.nombre,
    dia_semana.nombre_dia_semana,
    clase.hora_inicio,
    clase.duracion,
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
    SELECT grupo.id
    FROM grupo
    INNER JOIN curso ON grupo.fk_id_curso = curso.id
    INNER JOIN oferta_academica ON curso.fk_id_oferta_academica = oferta_academica.id_oferta_academica
    INNER JOIN anio_periodo_academico ON oferta_academica.fk_id_anio_periodo_academico = anio_periodo_academico.id_anio_periodo_academico
    WHERE grupo.fk_id_docente_asignado = ?
    AND anio_periodo_academico.anio = ? 
    AND anio_periodo_academico.fk_id_periodo_academico= ?
    );`,
    descripcion: 'Horario de un docente en un periodo academico'
  },

  23: {
    metodo: metodos.post,
    parametros: ['idUsuario'],
    consulta: `SELECT contrasena_hash
    FROM usuario
    WHERE id_usuario = ?;`,
    descripcion: 'Validación de la contraseña de un usuario'
  }
  // parametros: {
  //   "idUsuario": 123,
  //   "contrasenaIngresada": "123"
  // }
}
