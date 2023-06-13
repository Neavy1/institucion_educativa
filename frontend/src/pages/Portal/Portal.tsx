import { IonPage } from '@ionic/react'
import PortalEstudiante from '../../components/PortalEstudiante/PortalEstudiante'
import Header from '../../components/Toolbar/Header'
import './Portal.css'

const Portal: React.FC = () => {
  return (
    <IonPage>
      <Header />
      <PortalEstudiante />
    </IonPage>
  )
}

export default Portal
