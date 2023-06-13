import { IonButtons, IonHeader, IonMenuButton, IonToolbar } from '@ionic/react'

import Perfil from '../Perfil/Perfil'
import './Header.css'

const Header: React.FC = () => {
  return (
    <IonHeader>
      <IonToolbar color='primary'>
        <IonMenuButton slot='start' />
        <IonButtons color='secondary' slot='end'>
          <Perfil />
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  )
}

export default Header
