/* eslint-disable @typescript-eslint/indent */
import { calendarSharp, easelSharp, schoolSharp } from 'ionicons/icons'
export interface Iroles {
  estudiante: string
  docente: string
  administrativo: string
}

export const roles: Iroles = {
  estudiante: 'estudiante',
  docente: 'docente',
  administrativo: 'administrativo'
}

export interface IportalProps {
  rolUsuario: number
  opcionSeleccionada: number
}

export interface Ipestanas {
  iosIcon: string
  mdIcon: string
  titulo: string
  subpaneles: string[]
  indexSubpanels: number[]
}

export interface Imetodos {
  get: string
  post: string
  put: string
  delete: string
}

export type Iconsultas = Record<
  number,
  {
    metodo: string
    descripcion: string
    parametros: string[]
  }
>

export const pestanasEstudiante: Ipestanas[] = [
  {
    titulo: 'Mis cursos',
    iosIcon: easelSharp,
    mdIcon: easelSharp,
    subpaneles: ['Notas parciales', 'Asignaturas'],
    indexSubpanels: [1, 2]
  },
  {
    titulo: 'Horario',
    iosIcon: calendarSharp,
    mdIcon: calendarSharp,
    subpaneles: ['Ver horario', 'Editar horario'],
    indexSubpanels: [3, 4]
  },
  {
    titulo: 'Matrícula académica',
    iosIcon: schoolSharp,
    mdIcon: schoolSharp,
    subpaneles: ['Pensum de mi programa', 'Historial académico', 'Mi progreso'],
    indexSubpanels: [5, 6]
  }
]
export const pestanasDocente: Ipestanas[] = [
  {
    titulo: 'Mis cursos',
    iosIcon: easelSharp,
    mdIcon: easelSharp,
    subpaneles: ['Notas parciales', 'Asignaturas'],
    indexSubpanels: [1, 2]
  },
  {
    titulo: 'Horario',
    iosIcon: calendarSharp,
    mdIcon: calendarSharp,
    subpaneles: ['Ver horario', 'Editar horario'],
    indexSubpanels: [3, 4]
  },
  {
    titulo: 'Matrícula académica',
    iosIcon: schoolSharp,
    mdIcon: schoolSharp,
    subpaneles: ['Pensum de mi programa', 'Historial académico', 'Mi progreso'],
    indexSubpanels: [5, 6]
  }
]
export const pestanasAdministrativo: Ipestanas[] = [
  {
    titulo: 'Mis cursos',
    iosIcon: easelSharp,
    mdIcon: easelSharp,
    subpaneles: ['Notas parciales', 'Asignaturas'],
    indexSubpanels: [1, 2]
  },
  {
    titulo: 'Horario',
    iosIcon: calendarSharp,
    mdIcon: calendarSharp,
    subpaneles: ['Ver horario', 'Editar horario'],
    indexSubpanels: [3, 4]
  },
  {
    titulo: 'Matrícula académica',
    iosIcon: schoolSharp,
    mdIcon: schoolSharp,
    subpaneles: ['Pensum de mi programa', 'Historial académico', 'Mi progreso'],
    indexSubpanels: [5, 6]
  }
]

export interface IobtenerRuta {
  numeroConsulta: number | string
  arregloParametros: number[] | string[]
}

export interface IpeticionHTTP {
  url: string
  metodo: string
}

export interface IdatosConsultaEspecial {
  comparacionExitosa: boolean
  contrasenaCorrecta: boolean
}

export interface IvalidacionInicioSesion {
  exito: boolean
  estado: number
  descripcion: string
  datosConsultaEspecial: IdatosConsultaEspecial
}

export interface Ierror {
  estado: false
  mostrarAlert: false
  mostrarToast: true
  tipoError: string
  mensajeParaElUsuario: {
    titulo: string
    mensaje: string
  }
  mensajeConsola: string
  descripcion: string
  datosAdicionales?: any
}

export interface IiniciarSesion {
  idUsuario: number
  contrasenaIngresada: string
}

export interface IparametrosInicioSesion {
  idUsuario: number
  contrasenaIngresada: string
}

export interface IpeticionApi {
  numeroConsulta: number
  arregloParametros: number[] | string[]
  datosAdicionales: any
}
