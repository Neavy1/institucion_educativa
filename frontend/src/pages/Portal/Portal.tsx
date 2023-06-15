import { IonPage } from '@ionic/react'
import InicioAdministrativo from '../../Tabs/Administrativos/InicioAdministrativo/InicioAdministrativo'
import InicioDocente from '../../Tabs/Docentes/InicioEstudiante/InicioDocente'
import InicioEstudiante from '../../Tabs/Estudiantes/InicioEstudiante/InicioEstudiante'
import Header from '../../components/Header/Header'
import type { IportalProps } from '../../interfaces'
import './Portal.css'

export type IContenidoPortal = Record<number, JSX.Element>

const Portal: React.FC<IportalProps> = ({ rolUsuario, opcionSeleccionada }) => {
  const paginasEstudiante: IContenidoPortal = {
    1: <InicioEstudiante opcionSeleccionada={opcionSeleccionada} />,
    2: <InicioDocente opcionSeleccionada={opcionSeleccionada} />,
    3: <InicioAdministrativo opcionSeleccionada={opcionSeleccionada} />
  }
  return (
    <IonPage>
      <Header />
      {paginasEstudiante[rolUsuario]}
    </IonPage>
  )
}

export default Portal
