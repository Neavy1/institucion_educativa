import type { Request, Response } from 'express'
import { obtenerConsulta } from '../db/queries'
import { mensajesUsuario } from '../utils/dictionaries'
import { enviarRespuesta } from './auxiliar.functions'
import { consultarEnDB } from './controller'

const listaProgramasAcademicos = async (
  req: Request,
  res: Response
): Promise<void> => {
  const consulta = obtenerConsulta({
    modulo: 1,
    numeroConsulta: 1
  })
  const respuestaDB = await consultarEnDB({ consulta })

  enviarRespuesta({
    res,
    mensaje: mensajesUsuario[1],
    respuestaDB
  })
}

const listaAsignaturasProgramaAcademico = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { idProgramaAcademico } = req.params
  const consulta = obtenerConsulta({
    modulo: 1,
    numeroConsulta: 2
  })
  const respuestaDB = await consultarEnDB({
    consulta,
    arregloParametros: [idProgramaAcademico]
  })

  enviarRespuesta({
    res,
    mensaje: mensajesUsuario[2],
    respuestaDB
  })
}

const listaAsignaturasYCursosDeExtension = async (
  req: Request,
  res: Response
): Promise<void> => {
  const consulta = obtenerConsulta({
    modulo: 1,
    numeroConsulta: 3
  })
  const respuestaDB = await consultarEnDB({ consulta })

  enviarRespuesta({
    res,
    mensaje: mensajesUsuario[2],
    respuestaDB
  })
}

export {
  listaAsignaturasProgramaAcademico,
  listaAsignaturasYCursosDeExtension,
  listaProgramasAcademicos
}
