import axios, { type AxiosResponse } from 'axios'
import { API_ENDPOINT } from '../config/config'
import { consultas, metodos } from '../config/queries'
import type {
  IobtenerRuta as IobtenerPeticionHTTP,
  IpeticionApi,
  IpeticionHTTP
} from '../interfaces'
import { manejadorDeErrores } from '../utils/errorHandler'
const obtenerPeticionHTTP = ({
  numeroConsulta,
  arregloParametros
}: IobtenerPeticionHTTP): IpeticionHTTP => {
  const metodo = consultas[Number(numeroConsulta)].metodo
  let url = `${API_ENDPOINT}/api?numeroConsulta=${numeroConsulta}`
  arregloParametros.forEach((parametro, indice) => {
    url += `&parametro${indice + 1}=${parametro}`
  })
  const peticionHTTP: IpeticionHTTP = {
    metodo,
    url
  }
  return peticionHTTP
}

export const peticionApi = async ({
  numeroConsulta,
  arregloParametros,
  datosAdicionales
}: IpeticionApi): Promise<any> => {
  let respuesta: AxiosResponse | undefined
  const peticionHttp = obtenerPeticionHTTP({
    numeroConsulta,
    arregloParametros
  })

  try {
    if (peticionHttp.metodo === metodos.get) {
      respuesta = await axios.get(peticionHttp.url)
    } else {
      respuesta = await axios.post(peticionHttp.url, datosAdicionales)
    }
  } catch (error) {
    manejadorDeErrores({ error })
  }

  // eslint-disable-next-line @typescript-eslint/no-unsafe-return
  return respuesta?.data
}
