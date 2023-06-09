import { IonContent } from '@ionic/react'
import './InicioAdministrativo.css'
// import Bienvenida from '../../../components/Welcome/Welcome'
import DetallesPerfil from '../../../components/ProfileDetail/ProfileDetail'
import Bienvenida from '../../../components/Welcome/Welcome'

export type Ipaginas = Record<number, JSX.Element>
const paginasAdministrativo: Ipaginas = {
  1: <Bienvenida />,
  2: <DetallesPerfil />
}

export interface IportalEstudianteProps {
  opcionSeleccionada: number
}

const PortalAdministrativo: React.FC<IportalEstudianteProps> = ({
  opcionSeleccionada
}) => {
  return <IonContent>{paginasAdministrativo[opcionSeleccionada]}</IonContent>
}

export default PortalAdministrativo
