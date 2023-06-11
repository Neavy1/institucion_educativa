// import { pool } from '../db/db'
import type {
  IParametrosenviarRespuesta,
  IrespuestaBackend
} from '../interfaces'

const enviarRespuesta = ({
  res,
  mensaje,
  respuestaDB,
  fallo
}: IParametrosenviarRespuesta): void => {
  let respuestaBackend: IrespuestaBackend = {
    exito: false,
    estado: 404
  }

  if (fallo === undefined && respuestaDB !== undefined) {
    if (respuestaDB.exito) {
      respuestaBackend = {
        exito: true,
        estado: 200,
        respuestaDB,
        mensaje
      }
    } else {
      respuestaBackend = {
        exito: false,
        estado: 500,
        mensaje,
        error: respuestaDB.error
      }
    }
  } else {
    respuestaBackend = {
      exito: false,
      estado: 404,
      mensaje
    }
  }

  res.status(respuestaBackend.estado).json(respuestaBackend)
}

export { enviarRespuesta }
