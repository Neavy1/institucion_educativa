/* eslint-disable @typescript-eslint/indent */
import type { Response } from 'express'
import type { RowDataPacket } from 'mysql2'

export interface MiError extends Error {
  status?: number
}

export interface IrespuestaBackend {
  exito: boolean
  estado: number
  mensaje?: any
  respuestaDB?: IrespuestaDB
  error?: any
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
  mensaje: string
  respuestaDB?: IrespuestaDB
}

export interface IinsertarNombreTablaEnConsultaParametros {
  modulo: number
  numeroConsulta: number
}
export interface IconsultarDB {
  consulta: string
  arregloParametros?: number[] | string[]
}

export interface IrespuestaDB {
  exito: boolean
  cantidadResultados?: number
  datos: RowDataPacket[]
  error?: Imysql2Error
}
export const metodos = {
  get: 'get',
  post: 'post',
  put: 'put',
  delete: 'delete'
}
// export interface Iconsulta {}
export type Iconsultas = Record<
  number,
  {
    ruta: string
    metodo?: string // TODO: remove ?
    consulta: string
    parametros: string[]
  }
>
export type Iconsultas2 = Record<number, Record<number, string>>
