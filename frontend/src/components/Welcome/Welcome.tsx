import { IonTitle } from '@ionic/react'
import type React from 'react'
import bienvenida from '../../assets/img/bienvenidaportal.png'

const Bienvenida: React.FC = () => {
  return (
    <>
      <IonTitle className='ion-text-center ion-margin-vertical'>
        ¡Bienvenido al portal estudiantil!
      </IonTitle>
      <img className='ion-margin' src={bienvenida} alt='Bienvenida'></img>
    </>
  )
}

export default Bienvenida
