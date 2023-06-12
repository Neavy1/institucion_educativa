/* eslint-disable @typescript-eslint/indent */
import type { Response } from 'express'
import type { OkPacket, RowDataPacket } from 'mysql2'

export interface MiError extends Error {
  status?: number
}

export interface IrespuestaBackend {
  exito: boolean
  estado: number
  mensaje?: string
  descripcion?: string
  respuestaBD?: IrespuestaBD
  datosConsultaEspecial?: any
  error?: any
}
export interface IerrorSQLFiltrado {
  codigoError: number
  EstadoSQL: string
  codigoInterno: string
  detalleError?: string
}
export interface Imysql2Error {
  message: string
  code: string
  errno: number
  sql: string
  sqlState: string
  sqlMessage: string
}

export interface IParametrosenviarRespuesta {
  fallo?: boolean
  res: Response
  mensaje?: string
  descripcion?: string
  respuestaBD?: IrespuestaBD
  datosConsultaEspecial?: any
}

export interface IobtenerRuta {
  numeroConsulta: number | string
  arregloParametros: number[] | string[]
}
export interface IconsultaRespuesta {
  consulta: string
  descripcion: string
  cantidadDeParametros: number
}
export interface IconsultarBD {
  consulta: IconsultaRespuesta
  arregloParametros?: number[] | string[]
}
export interface IconsultarBDPOST {
  res: Response
  body: Ibody
  nConsulta: number
}

export type Ibody = Record<string, any>

export interface IcontrasenaUsuarioBD {
  contrasena_hash: string
}
export interface IrespuestaBD {
  exito: boolean
  descripcion?: string
  registrosAfectados?: number
  cantidadResultados?: number
  datos: RowDataPacket | OkPacket
  error?: Imysql2Error | IerrorSQLFiltrado
}
export interface IvalidarRespuestaBD {
  res: Response
  respuestaBD: IrespuestaBD
  consultaDeLectura: boolean
}
export interface IrespuestaBDValidada {
  consultaExitosa: boolean
  respuestaRevisadaBD: IrespuestaBD
  descripcion: string
  mensaje: string
}

export interface IvalidarParametrosConsulta {
  res: Response
  numeroConsulta: any
  consultasEspeciales: IconsultasEspeciales
  parametros?: any[]
}
export interface IconsultaDBconValidacionTotal {
  res: Response
  nConsulta: number
  nuevoArregloParametros: any[]
}
export interface IparametrosYConsultaValidados {
  parametrosCorrectos: boolean
  consultaCorrecta: boolean
  resultadosConsulta: RowDataPacket[] | undefined
  descripcion: string | undefined
}
export interface IprocesarContrasena {
  resultadosConsulta: RowDataPacket[]
  contrasenaIngresada: any
}
export interface IvalidacionParametros {
  parametrosCorrectos: boolean
  consultaDeLectura: boolean
  nConsulta: number
  consulta: IconsultaRespuesta
  mensaje?: string
  arregloParametros?: string[]
}

export interface IconsultarEnBDYValidar {
  res: Response
  parametrosValidados: IvalidacionParametros
}
export interface IencriptarContrasena {
  encriptacionExitosa: boolean
  contrasenaHash: string
  error?: string
}
export interface IcompararContrasena {
  comparacionExitosa: boolean
  contrasenaCorrecta: boolean
  error?: string
}

export interface IvalidarContrasena {
  contrasenaIngresada: any
  contrasenaHash: any
}
export interface IcontrasenaProcesada {
  comparacionContrasena: IcompararContrasena
  mensaje?: string
}

export type Iconsultas = Record<
  number,
  {
    metodo: string
    descripcion: string
    consulta: string
    parametros: string[]
  }
>
export type Iconsultas2 = Record<number, Record<number, string>>

export type IconsultasEspeciales = Record<
  number,
  (parametros: IconsultarBDPOST) => Promise<void>
>

interface Imetodos {
  get: string
  post: string
  put: string
  delete: string
}

// Constantes
export const metodos: Imetodos = {
  get: 'GET',
  post: 'POST',
  put: 'PUT',
  delete: 'DELETE'
}
