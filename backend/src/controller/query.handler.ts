import type { Request, Response } from 'express'
import { type RowDataPacket } from 'mysql2'
import type {
  IalmacenDeConsulas,
  Ibody,
  IconsultarBDPOST,
  IcontrasenaUsuarioBD
} from '../interfaces'
import { errores } from '../utils/dictionaries'
import {
  enviarRespuesta,
  validarContrasena,
  validarParametrosConsulta,
  validarRespuestaBD
} from './auxiliar.functions'
import { consultarEnBD } from './controller'

const validarContrasenaUsuario = async ({
  res,
  body,
  parametrosValidados
}: IconsultarBDPOST): Promise<void> => {
  const { idUsuario, contrasenaIngresada } = body
  let mensaje: string | undefined
  let datosParaEnviar

  const respuestaBD = await consultarEnBD({
    consulta: parametrosValidados.consulta,
    arregloParametros: [idUsuario]
  })

  const respuestaBDValidada = validarRespuestaBD({
    respuestaBD,
    consultaDeLectura: parametrosValidados.consultaDeLectura,
    nConsulta: parametrosValidados.nConsulta
  })

  const comparacionContrasena = await validarContrasena({
    contrasenaIngresada: contrasenaIngresada as string,
    contrasenaHash: (
      (
        respuestaBDValidada.respuestaRevisadaBD.datos as RowDataPacket
      )[0] as IcontrasenaUsuarioBD
    ).contrasena_hash
  })

  if (comparacionContrasena.comparacionExitosa) {
    datosParaEnviar = comparacionContrasena
  } else {
    mensaje = comparacionContrasena.error
  }

  enviarRespuesta({
    res,
    datosConsultaEspecial: datosParaEnviar,
    descripcion: respuestaBD.descripcion,
    mensaje
  })
}

const almacenDeConsulas: IalmacenDeConsulas = {
  23: validarContrasenaUsuario
}

const manejadorDeConsultas = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { numeroConsulta, parametro1, parametro2, parametro3 } = req.query

  const parametrosValidados = validarParametrosConsulta({
    numeroConsulta: numeroConsulta as string,
    almacenDeConsulas,
    parametros: [
      parametro1 as string,
      parametro2 as string,
      parametro3 as string
    ]
  })

  if (!parametrosValidados.parametrosCorrectos) {
    enviarRespuesta({
      res,
      mensaje: parametrosValidados.mensaje
    })
    return
  }

  if (parametrosValidados.consultaDeLectura) {
    const respuestaBD = await consultarEnBD({
      consulta: parametrosValidados.consulta,
      arregloParametros: parametrosValidados.arregloParametros
    })

    const respuestaBDValidada = validarRespuestaBD({
      respuestaBD,
      consultaDeLectura: parametrosValidados.consultaDeLectura,
      nConsulta: parametrosValidados.nConsulta
    })

    enviarRespuesta({
      res,
      descripcion: respuestaBDValidada.descripcion,
      respuestaBD: respuestaBDValidada.respuestaRevisadaBD,
      mensaje: respuestaBDValidada.mensaje
    })
  } else {
    const nConsulta = parametrosValidados.nConsulta
    if (
      almacenDeConsulas[nConsulta] !== undefined &&
      almacenDeConsulas[nConsulta] !== null
    ) {
      await almacenDeConsulas[nConsulta]({
        res,
        body: req.body as Ibody,
        parametrosValidados
      })
    } else {
      enviarRespuesta({
        res,
        mensaje: errores[6]
      })
    }
  }
}

export { manejadorDeConsultas }
