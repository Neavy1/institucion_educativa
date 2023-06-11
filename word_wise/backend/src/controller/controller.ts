/* eslint-disable @typescript-eslint/indent */
import type { RowDataPacket } from 'mysql2'
import { db } from '../db/db'
import type { IconsultarDB, Imysql2Error, IrespuestaDB } from '../interfaces'

const consultarEnDB = async ({
  consulta,
  arregloParametros
}: IconsultarDB): Promise<IrespuestaDB> => {
  const respuesta: IrespuestaDB = { exito: false, datos: [] }
  const parametros = arregloParametros ?? []
  let datos: RowDataPacket[]

  try {
    datos = ((await db.query(consulta, parametros)) as RowDataPacket[][])[0]
    respuesta.datos = datos
    respuesta.cantidadResultados = datos.length
    respuesta.exito = true
  } catch (error) {
    respuesta.exito = false
    respuesta.error = error as Imysql2Error
  }

  return respuesta
}

export { consultarEnDB }
