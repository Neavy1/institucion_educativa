import type { Iconsultas, Imetodos } from '../interfaces'

// Constantes
export const metodos: Imetodos = {
  get: 'GET',
  post: 'POST',
  put: 'PUT',
  delete: 'DELETE'
}

export const consultas: Iconsultas = {
  //? 1. Módulo de inicio
  1: {
    metodo: metodos.get,
    parametros: [],
    descripcion: 'Lista de programas académicos'
  },

  2: {
    metodo: metodos.get,
    parametros: ['idProgramaAcademico'],
    descripcion: 'Todas las asignaturas de un programa académico'
  },

  3: {
    metodo: metodos.get,
    parametros: [],
    descripcion: 'Todas las asignaturas y cursos de extensión'
  },

  4: {
    metodo: metodos.get,
    parametros: [],
    descripcion:
      'Lista de profesores con su nombre, apellido, departamento y foto de perfil'
  },
  //? 2. Módulo de Login
  5: {
    metodo: metodos.get,
    parametros: ['idUsuario', 'idRol'],
    descripcion: 'Todos los datos del usuario accesibles para él'
  },

  //? 3. Módulo estudiante
  6: {
    metodo: metodos.get,
    parametros: [],
    descripcion: 'id del anio + periodo academio'
  },

  7: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'anio', 'idPeriodoAcademico'],
    descripcion: 'Lista de ofertas académicas de un estudiante'
  },

  8: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'anio', 'idPeriodoAcademico'],
    descripcion:
      'Historial del estudiante en todos sus grupos de una anio y periodo académico'
  },

  //! Es mejor dejarlo para después de la entrega :v
  9: {
    metodo: metodos.get,
    parametros: ['idEstudiante'],
    descripcion: 'Historial del estudiante en TODA su historia'
  },

  10: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    descripcion: 'id de la matrícula académica de un estudiante'
  },

  11: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    descripcion:
      'Notas finales de un estudiante en sus asignaturas matriculadas un semestre'
  },

  13: {
    metodo: metodos.post,
    parametros: ['nuevaContrasena', 'idUsuario'],
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
    descripcion:
      'Créditos matriculados por un estudiante en un periodo académico y en un programa académico'
  },

  15: {
    //! Esta vainda retorna los flotantes como strings
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    descripcion: 'Ubicación semestral de un estudiante en un programa académico'
  },

  16: {
    metodo: metodos.get,
    parametros: ['idEstudiante'],
    descripcion: 'Último periodo académico que matriculó un estudiante'
  },

  //TODO: Esta función se va a eliminar en favor de la 18
  17: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idGrupo'],
    descripcion:
      'Registra la nota final estudiante en un grupo en la tabla de notas'
  },

  18: {
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idGrupo'],
    descripcion:
      'Registrar como aprobada una asignatura por un estudiante si su nota en el grupo es >= 3 en su lista de materias aprobadas en el programa académico correspondiente'
  },

  19: {
    //! Hay que probarlo con más datos cuando los estudiantes tengan más notas
    metodo: metodos.get,
    parametros: ['idEstudiante', 'idOfertaAcademica'],
    descripcion: 'Promedio de un estudiante en una oferta academica'
  },

  //? 3. Módulo de Docente
  20: {
    metodo: metodos.get,
    parametros: ['idDocente'],
    descripcion: 'Lista de las asignaturas que enseña un docente'
  },
  21: {
    metodo: metodos.get,
    parametros: ['idDocente', 'anio', 'idPeriodoAcademico'],
    descripcion:
      'Lista de grupos en los que enseña un docente en un periodo académico'
  },

  22: {
    metodo: metodos.get,
    parametros: ['idDocente', 'anio', 'idPeriodoAcademico'],
    descripcion: 'Horario de un docente en un periodo academico'
  },

  23: {
    metodo: metodos.post,
    parametros: ['idUsuario', 'contrasenaIngresada'],
    descripcion: 'Validación de la contraseña de un usuario'
  }
  // parametros: {
  //   "idUsuario": 123,
  //   "contrasenaIngresada": "123"
  // }
}
