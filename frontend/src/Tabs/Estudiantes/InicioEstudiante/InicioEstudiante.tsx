import { IonContent } from '@ionic/react'
import './InicioEstudiante.css'
// import Bienvenida from '../../../components/Welcome/Welcome'
import Horario from '../../../components/Horario/Horario'
import DetallesPerfil from '../../../components/ProfileDetail/ProfileDetail'
import Bienvenida from '../../../components/Welcome/Welcome'

export type Ipaginas = Record<number, JSX.Element>
const paginasEstudiante: Ipaginas = {
  1: <Bienvenida />,
  2: <DetallesPerfil />,
  3: <Horario />
}

export interface IcontenidoPortal {
  opcionSeleccionada: number
}

const InicioEstudiante: React.FC<IcontenidoPortal> = ({
  opcionSeleccionada
}) => {
  return <IonContent>{paginasEstudiante[3]}</IonContent>
}

export default InicioEstudiante
