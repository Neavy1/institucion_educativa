// import { pool } from '../db/db'
import bcrypt from 'bcrypt'
import type { OkPacket, RowDataPacket } from 'mysql2'
import { SALT_ROUNDS } from '../config/config'
import { consultas, obtenerConsulta } from '../db/queries'
import type {
  IParametrosenviarRespuesta,
  IcompararContrasena,
  IcontrasenaProcesada,
  IcontrasenaUsuarioBD,
  IencriptarContrasena,
  IerrorSQLFiltrado,
  Imysql2Error,
  IprocesarContrasena,
  IrespuestaBDValidada,
  IrespuestaBackend,
  IvalidacionParametros,
  IvalidarContrasena,
  IvalidarParametrosConsulta,
  IvalidarRespuestaBD
} from '../interfaces'
import { errores, mensajesUsuario } from '../utils/dictionaries'

const validarRespuestaBD = ({
  res,
  respuestaBD,
  consultaDeLectura
}: IvalidarRespuestaBD): IrespuestaBDValidada => {
  let errorSQLFiltrado: IerrorSQLFiltrado | undefined

  const respuestaValidada: IrespuestaBDValidada = {
    consultaExitosa: false,
    respuestaRevisadaBD: respuestaBD,
    descripcion: respuestaBD.descripcion ?? '',
    mensaje: ''
  }

  if (respuestaBD.exito) {
    const registrosAfectados = (respuestaBD.datos as OkPacket).affectedRows ?? 0
    respuestaBD.registrosAfectados = registrosAfectados
    respuestaValidada.mensaje = mensajesUsuario[0]
    respuestaValidada.consultaExitosa = true
    if (consultaDeLectura) {
      if (
        respuestaBD.cantidadResultados !== undefined &&
        respuestaBD.cantidadResultados <= 0
      ) {
        respuestaValidada.mensaje = mensajesUsuario[2]
      }
    } else {
      if (registrosAfectados <= 0) {
        respuestaValidada.mensaje = mensajesUsuario[1]
      }
    }
  } else {
    respuestaValidada.mensaje = errores[0]

    if (respuestaBD.error !== undefined) {
      const { errno, sqlState, code } = respuestaBD.error as Imysql2Error
      errorSQLFiltrado = {
        codigoError: errno,
        EstadoSQL: sqlState,
        codigoInterno: code,
        detalleError: errores[errno] ?? undefined
      }
      console.log(respuestaBD.error)
      respuestaValidada.respuestaRevisadaBD = {
        exito: false,
        datos: [] as RowDataPacket,
        error: errorSQLFiltrado
      }
    }
  }

  if (!respuestaValidada.consultaExitosa) {
    enviarRespuesta({
      res,
      respuestaBD: respuestaValidada.respuestaRevisadaBD,
      mensaje: respuestaValidada.mensaje,
      descripcion: respuestaValidada.descripcion,
      fallo: true
    })
  }

  return respuestaValidada
}

const validarParametrosConsulta = ({
  res,
  numeroConsulta,
  consultasEspeciales,
  parametros = []
}: IvalidarParametrosConsulta): IvalidacionParametros => {
  const nConsulta = Number(numeroConsulta)
  const validacionParametros: IvalidacionParametros = {
    parametrosCorrectos: false,
    consultaDeLectura: true,
    nConsulta,
    consulta: {
      consulta: '',
      descripcion: '',
      cantidadDeParametros: 0
    }
  }

  if (consultas[nConsulta] !== undefined && consultas[nConsulta] !== null) {
    const consulta = obtenerConsulta(nConsulta)
    const arregloParametros = parametros
      .filter(
        (parametro) =>
          parametro !== undefined && parametro !== null && parametro !== ''
      )
      .map((parametro) => (parametro as string).toString())

    validacionParametros.consulta = consulta
    validacionParametros.arregloParametros = arregloParametros
    if (
      consultasEspeciales[nConsulta] !== undefined &&
      consultasEspeciales[nConsulta] !== null
    ) {
      validacionParametros.parametrosCorrectos = true
      validacionParametros.consultaDeLectura = false
    } else if (arregloParametros.length >= consulta.cantidadDeParametros) {
      validacionParametros.parametrosCorrectos = true
    } else {
      validacionParametros.mensaje = errores[3]
    }
  } else {
    validacionParametros.mensaje = errores[2]
  }

  if (!validacionParametros.parametrosCorrectos) {
    enviarRespuesta({
      res,
      mensaje: validacionParametros.mensaje,
      fallo: true
    })
  }

  return validacionParametros
}

const enviarRespuesta = ({
  res,
  mensaje,
  respuestaBD,
  descripcion,
  datosConsultaEspecial,
  fallo
}: IParametrosenviarRespuesta): void => {
  const respuestaBackend: IrespuestaBackend = {
    exito: false,
    estado: 404,
    descripcion: descripcion ?? '',
    mensaje,
    respuestaBD,
    datosConsultaEspecial: datosConsultaEspecial as any[]
  }

  if (fallo === undefined || (fallo !== undefined && !fallo)) {
    respuestaBackend.exito = true
    respuestaBackend.estado = 200
    if (respuestaBD?.exito ?? false) {
      delete respuestaBackend.respuestaBD?.descripcion
    }
  } else if (fallo !== undefined && fallo) {
    respuestaBackend.exito = false
    respuestaBackend.estado = 500
  }

  res.status(respuestaBackend.estado).json(respuestaBackend)
}

const encriptarContrasena = async (
  contrasena: string
): Promise<IencriptarContrasena> => {
  let contrasenaEncriptada: IencriptarContrasena = {
    encriptacionExitosa: false,
    contrasenaHash: ''
  }
  try {
    // Generar el hash
    const contrasenaHash = await bcrypt.hash(contrasena, Number(SALT_ROUNDS))

    contrasenaEncriptada = {
      encriptacionExitosa: true,
      contrasenaHash
    }
  } catch (error) {
    contrasenaEncriptada.error = errores[4]
  }
  return contrasenaEncriptada
}

const validarContrasena = async ({
  contrasenaIngresada,
  contrasenaHash
}: IvalidarContrasena): Promise<IcompararContrasena> => {
  const contrasenaComparada: IcompararContrasena = {
    comparacionExitosa: false,
    contrasenaCorrecta: false
  }
  try {
    const contrasenaCoincide = await bcrypt.compare(
      (contrasenaIngresada as string).toString(),
      (contrasenaHash as string).toString()
    )
    if (contrasenaCoincide) {
      contrasenaComparada.comparacionExitosa = true
      contrasenaComparada.contrasenaCorrecta = true
    } else {
      contrasenaComparada.comparacionExitosa = true
    }
  } catch (error) {
    contrasenaComparada.error = errores[4]
  }
  return contrasenaComparada
}

const procesarContrasena = async ({
  resultadosConsulta,
  contrasenaIngresada
}: IprocesarContrasena): Promise<IcontrasenaProcesada> => {
  let mensaje: string | undefined
  let comparacionContrasena: IcompararContrasena = {
    comparacionExitosa: false,
    contrasenaCorrecta: false
  }
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
  const contrasenaProcesada: IcontrasenaProcesada = {
    mensaje,
    comparacionContrasena
  }
  return contrasenaProcesada
}

export {
  encriptarContrasena,
  enviarRespuesta,
  procesarContrasena,
  validarContrasena,
  validarParametrosConsulta,
  validarRespuestaBD
}
