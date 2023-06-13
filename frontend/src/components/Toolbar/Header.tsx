import {
  IonAccordion,
  IonAccordionGroup,
  IonAvatar,
  IonButtons,
  IonHeader,
  IonItem,
  IonLabel,
  IonMenuButton,
  IonTitle,
  IonToolbar
} from '@ionic/react'

import avatar from '../../assets/img/avatar.svg'
import { roles } from '../../interfaces'
import './Header.css'

const Header: React.FC = () => {
  return (
    <IonHeader>
      <IonToolbar>
        <IonMenuButton slot='start' />
        <IonTitle>{roles[1]}</IonTitle>
        <IonButtons slot='end'>
          <IonLabel>Jose Alejandro Salazar</IonLabel>
          <IonAccordionGroup>
            <IonAccordion>
              <IonItem slot='header' color='light'>
                <IonAvatar className='ion-margin-vertical'>
                  <img className='avataricon' src={avatar} alt='avatar' />
                </IonAvatar>
              </IonItem>
              <div className='ion-padding' slot='content'>
                Mi perfil
              </div>
              <div className='ion-padding' slot='content'>
                Salir
              </div>
            </IonAccordion>
          </IonAccordionGroup>
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  )
}

export default Header
