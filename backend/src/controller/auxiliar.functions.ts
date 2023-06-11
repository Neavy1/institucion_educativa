// import { pool } from '../db/db'
import bcrypt from 'bcrypt'
import { type OkPacket } from 'mysql2'
import { SALT_ROUNDS } from '../config/config'
import { consultas, obtenerConsulta } from '../db/queries'
import type {
  IParametrosenviarRespuesta,
  IcompararContrasena,
  IencriptarContrasena,
  IerrorSQLFiltrado,
  IrespuestaBDValidada,
  IrespuestaBackend,
  IvalidacionParametros,
  IvalidarContrasena,
  IvalidarParametrosConsulta,
  IvalidarRespuestaBD
} from '../interfaces'
import { errores, mensajesUsuario } from '../utils/dictionaries'

const validarRespuestaBD = ({
  respuestaBD,
  consultaDeLectura
}: IvalidarRespuestaBD): IrespuestaBDValidada => {
  let mensaje = ''

  const descripcion = respuestaBD.descripcion ?? ''
  if (respuestaBD.exito) {
    const registrosAfectados = (respuestaBD.datos as OkPacket).affectedRows ?? 0
    respuestaBD.registrosAfectados = registrosAfectados
    mensaje = mensajesUsuario[0]
    if (consultaDeLectura) {
      if (
        respuestaBD.cantidadResultados !== undefined &&
        respuestaBD.cantidadResultados <= 0
      ) {
        mensaje = mensajesUsuario[2]
      }
    } else {
      if (registrosAfectados <= 0) {
        mensaje = mensajesUsuario[1]
      }
    }
  } else {
    mensaje = errores[0]
  }

  const respuestaValidada: IrespuestaBDValidada = {
    descripcion,
    respuestaRevisadaBD: respuestaBD,
    mensaje
  }

  return respuestaValidada
}

const validarParametrosConsulta = ({
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
      .map((parametro) => Number(parametro))

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
  let respuestaBackend: IrespuestaBackend = {
    exito: false,
    estado: 404,
    descripcion: '',
    mensaje
  }

  if (fallo === undefined && respuestaBD !== undefined) {
    if (respuestaBD.exito) {
      respuestaBackend = {
        exito: true,
        estado: 200,
        respuestaBD,
        descripcion: descripcion ?? respuestaBackend.respuestaBD?.descripcion,
        mensaje
      }
      delete respuestaBackend.respuestaBD?.descripcion
    } else {
      let errorSQLFiltrado: IerrorSQLFiltrado | undefined
      if (respuestaBD.error !== undefined) {
        const { errno, sqlState, code } = respuestaBD.error
        errorSQLFiltrado = {
          codigoError: errno,
          EstadoSQL: sqlState,
          codigoInterno: code,
          detalleError: errores[errno] ?? undefined
        }
      }

      respuestaBackend = {
        exito: false,
        estado: 500,
        descripcion: descripcion ?? respuestaBackend.respuestaBD?.descripcion,
        error: errorSQLFiltrado,
        mensaje
      }
    }
  } else if (fallo !== undefined && !fallo) {
    respuestaBackend = {
      exito: true,
      estado: 200,
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      datosConsultaEspecial,
      mensaje
    }
  } else if (fallo !== undefined && fallo) {
    respuestaBackend = {
      exito: false,
      estado: 500,
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      datosConsultaEspecial,
      mensaje
    }
  }

  res.status(respuestaBackend.estado).json(respuestaBackend)
}

const encriptarContrasena = async (
  contrasena: string
): Promise<IencriptarContrasena> => {
  // TODO: hacer una función para crear contraseñas hasheadas rápido y probar el login
  let contrasenaEncriptada: IencriptarContrasena = {
    encriptacionExitosa: false,
    contrasenaHash: ''
  }
  try {
    // Generar el hash
    const contrasenaHash: string = await bcrypt.hash(contrasena, SALT_ROUNDS)
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
      contrasenaIngresada.toString(),
      contrasenaHash.toString()
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

export {
  encriptarContrasena,
  enviarRespuesta,
  validarContrasena,
  validarParametrosConsulta,
  validarRespuestaBD
}
