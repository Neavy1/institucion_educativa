import {
  IonButton,
  IonContent,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonPopover
} from '@ionic/react'
import { chevronDown, personCircleSharp } from 'ionicons/icons'
import avatar from '../../assets/img/avatar.svg'
import './Perfil.css'

const Perfil: React.FC = () => {
  return (
    <>
      <IonButton slot='end' id='popover-button'>
        <IonItem color='primary' lines='none' detail={false}>
          <IonIcon
            className='miIcono'
            size='large'
            // color='ion-color-primary-contrast'
            ios={avatar}
            md={avatar}
          />
          <IonIcon size='large' ios={chevronDown} md={chevronDown} />
        </IonItem>
      </IonButton>
      <IonPopover trigger='popover-button' dismissOnSelect={true}>
        <IonContent color='light'>
          <IonItem className='ion-margin-top' color='light'>
            <IonIcon
              className='iconopopover'
              color='primary'
              ios={personCircleSharp}
              md={personCircleSharp}
            />
          </IonItem>
          <IonList className='ion-no-padding'>
            <IonItem
              className='ion-text-center'
              color='light'
              button={true}
              detail={false}
            >
              <IonLabel> Jose Alejandro Salazar</IonLabel>
            </IonItem>
            <IonItem
              className='ion-text-center'
              color='light'
              button={true}
              detail={false}
            >
              <IonLabel> josesitoelpro@eldeveloper.com</IonLabel>
            </IonItem>
          </IonList>
        </IonContent>
      </IonPopover>
    </>
  )
}

export default Perfil
