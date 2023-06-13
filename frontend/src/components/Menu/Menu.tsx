import {
  IonAccordion,
  IonAccordionGroup,
  IonButton,
  IonCol,
  IonContent,
  IonFooter,
  IonGrid,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonMenu,
  IonRow,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToolbar
} from '@ionic/react'
import { homeSharp } from 'ionicons/icons'
import image from '../../assets/img/logo.svg'
import { pestanasAplicacion } from '../../interfaces'
import './Menu.css'

const Menu: React.FC = () => {
  return (
    <IonMenu disabled={false} contentId='main' type='overlay'>
      <IonHeader>
        <IonToolbar>
          <IonGrid>
            <IonCol>
              <IonRow className='ion-padding-vertical'>
                {
                  <div className='image'>
                    <img src={image} alt='avatar' />
                  </div>
                }
              </IonRow>
            </IonCol>
          </IonGrid>
        </IonToolbar>
      </IonHeader>

      <IonContent className='no-scroll ion-padding-top'>
        <IonGrid>
          <IonRow>
            <IonCol className='ion-margin-horizontal'>
              <IonTitle
                className='ion-margin-horizontal'
                style={{ fontSize: '1.5rem' }}
                color='primary'
              >
                Programa académico
              </IonTitle>
              <IonItem lines='full'>
                <IonSelect
                  placeholder='Selecciona tu programa'
                  justify='start'
                  interface='popover'
                >
                  <IonSelectOption value='brown'>
                    Ingeniería de Sistemas
                  </IonSelectOption>
                  <IonSelectOption value='blonde'>
                    Ingeniería industrial
                  </IonSelectOption>
                  <IonSelectOption value='red'>
                    Licenciatura en Bilingüismo
                  </IonSelectOption>
                </IonSelect>
              </IonItem>
            </IonCol>
          </IonRow>

          <IonRow>
            <IonCol className='margenVertical ion-margin-horizontal'>
              <IonItem
                className='inicio'
                routerLink='/portal/login'
                color='light'
                lines='none'
                detail={false}
              >
                <IonIcon slot='start' ios={homeSharp} md={homeSharp} />
                <IonLabel className='ion-margin-start'>Inicio</IonLabel>
              </IonItem>
            </IonCol>
          </IonRow>
          <IonRow>
            <IonCol className='ion-margin-horizontal'>
              <IonAccordionGroup multiple={true}>
                {pestanasAplicacion.map((pagina, index) => {
                  return (
                    <IonAccordion
                      key={index}
                      className='accordion margenVertical'
                    >
                      <IonItem
                        slot='header'
                        color='light'
                        lines='none'
                        detail={false}
                      >
                        <IonIcon
                          slot='start'
                          ios={pagina.iosIcon}
                          md={pagina.mdIcon}
                        />
                        <IonLabel className='ion-margin-start'>
                          {pagina.titulo}
                        </IonLabel>
                      </IonItem>
                      {pagina.subpaneles.map((subpanel, index) => {
                        return (
                          <IonItem
                            key={index}
                            className='ion-margin'
                            slot='content'
                            lines='full'
                            // onClick={}
                          >
                            <IonLabel>{subpanel}</IonLabel>
                          </IonItem>
                        )
                      })}
                    </IonAccordion>
                  )
                })}
              </IonAccordionGroup>
            </IonCol>
          </IonRow>
          <IonRow class='logout ion-margin-horizontal ion-padding-top'>
            <IonCol>
              <IonButton className='button' expand='block'>
                Cerrar sesión
              </IonButton>
            </IonCol>
          </IonRow>
        </IonGrid>
      </IonContent>
      <IonFooter className='ion-text-center'>
        <IonTitle color='secondary'>Word Wise</IonTitle>
      </IonFooter>
    </IonMenu>
  )
}

export default Menu
