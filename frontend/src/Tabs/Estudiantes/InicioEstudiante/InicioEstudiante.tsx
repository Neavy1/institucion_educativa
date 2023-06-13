import { IonContent, IonTitle } from '@ionic/react'
import bienvenida from '../../../assets/img/bienvenidaportal.png'
import './InicioEstudiante.css'

const PortalEstudiante: React.FC = () => {
  return (
    <IonContent>
      <IonTitle className='ion-text-center ion-margin-vertical'>
        ¡Bienvenido al portal estudiantil!
      </IonTitle>
      <img className='imagen' src={bienvenida} alt='Bienvenida'></img>
    </IonContent>
  )
}

export default PortalEstudiante
