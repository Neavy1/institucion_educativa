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
  rolUsuario: string
}

interface Ipestanas {
  iosIcon: string
  mdIcon: string
  titulo: string
  subpaneles: string[]
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

export const pestanasAplicacion: Ipestanas[] = [
  {
    titulo: 'Mis cursos',
    iosIcon: easelSharp,
    mdIcon: easelSharp,
    subpaneles: ['Notas parciales', 'Asignaturas']
  },
  {
    titulo: 'Horario',
    iosIcon: calendarSharp,
    mdIcon: calendarSharp,
    subpaneles: ['Ver horario', 'Editar horario']
  },
  {
    titulo: 'Matrícula académica',
    iosIcon: schoolSharp,
    mdIcon: schoolSharp,
    subpaneles: ['Pensum de mi programa', 'Historial académico', 'Mi progreso']
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
