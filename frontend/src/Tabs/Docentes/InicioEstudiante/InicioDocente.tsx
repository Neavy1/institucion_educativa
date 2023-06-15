import { IonContent } from '@ionic/react'
import './InicioDocente.css'
// import Bienvenida from '../../../components/Welcome/Welcome'
import DetallesPerfil from '../../../components/ProfileDetail/ProfileDetail'
import Bienvenida from '../../../components/Welcome/Welcome'

export type Ipaginas = Record<number, JSX.Element>
const paginasDocente: Ipaginas = {
  1: <Bienvenida />,
  2: <DetallesPerfil />
}

export interface IportalEstudianteProps {
  opcionSeleccionada: number
}

const PortalDocente: React.FC<IportalEstudianteProps> = ({
  opcionSeleccionada
}) => {
  return <IonContent>{paginasDocente[opcionSeleccionada]}</IonContent>
}

export default PortalDocente
