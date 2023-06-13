import type {
  IiniciarSesion,
  IparametrosInicioSesion,
  IvalidacionInicioSesion
} from '../interfaces'
import { peticionApi } from './controller'

const autorizarInicioSesion = async ({
  idUsuario,
  contrasenaIngresada
}: IiniciarSesion): Promise<IvalidacionInicioSesion> => {
  const parametros: IparametrosInicioSesion = {
    idUsuario,
    contrasenaIngresada
  }

  const accesoConcedido = (await peticionApi({
    numeroConsulta: 23,
    arregloParametros: [] as number[],
    datosAdicionales: parametros
  })) as IvalidacionInicioSesion

  return accesoConcedido
}

export { autorizarInicioSesion }
