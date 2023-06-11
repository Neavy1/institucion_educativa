import type { Request, Response } from 'express'
import { type RowDataPacket } from 'mysql2'
import type {
  Ibody,
  IcompararContrasena,
  IconsultarBDPOST,
  IconsultasEspeciales,
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
  let comparacionContrasena: IcompararContrasena = {
    comparacionExitosa: false,
    contrasenaCorrecta: false
  }

  const respuestaBD = await consultarEnBD({
    consulta: parametrosValidados.consulta,
    arregloParametros: [idUsuario]
  })

  const respuestaBDValidada = validarRespuestaBD({
    respuestaBD,
    consultaDeLectura: parametrosValidados.consultaDeLectura
  })

  const resultadosConsulta = respuestaBDValidada.respuestaRevisadaBD
    .datos as RowDataPacket[]

  if (resultadosConsulta.length > 0) {
    comparacionContrasena = await validarContrasena({
      contrasenaIngresada: contrasenaIngresada as string,
      contrasenaHash: (resultadosConsulta[0] as IcontrasenaUsuarioBD)
        .contrasena_hash
    })
    mensaje = comparacionContrasena.comparacionExitosa
      ? undefined
      : comparacionContrasena.error
  } else {
    mensaje = errores[7]
  }

  enviarRespuesta({
    res,
    datosConsultaEspecial: comparacionContrasena,
    descripcion: respuestaBD.descripcion,
    mensaje
  })
}

const consultasEspeciales: IconsultasEspeciales = {
  23: validarContrasenaUsuario
}

const manejadorDeConsultas = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { numeroConsulta, parametro1, parametro2, parametro3 } = req.query

  const parametrosValidados = validarParametrosConsulta({
    numeroConsulta: numeroConsulta as string,
    consultasEspeciales,
    parametros: [
      parametro1 as string,
      parametro2 as string,
      parametro3 as string
    ]
  })

  if (!parametrosValidados.parametrosCorrectos) {
    enviarRespuesta({
      res,
      mensaje: parametrosValidados.mensaje,
      fallo: true
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
      consultaDeLectura: parametrosValidados.consultaDeLectura
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
      consultasEspeciales[nConsulta] !== undefined &&
      consultasEspeciales[nConsulta] !== null
    ) {
      await consultasEspeciales[nConsulta]({
        res,
        body: req.body as Ibody,
        parametrosValidados
      })
    } else {
      enviarRespuesta({
        fallo: true,
        res,
        mensaje: errores[6]
      })
    }
  }
}

export { manejadorDeConsultas }
