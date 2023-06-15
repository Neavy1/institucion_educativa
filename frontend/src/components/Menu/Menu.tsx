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
import { useLocation } from 'react-router'
import image from '../../assets/img/logo.svg'
import {
  pestanasAdministrativo,
  pestanasDocente,
  pestanasEstudiante,
  type Ipestanas
} from '../../interfaces'
import './Menu.css'
export interface ImenuProps {
  setOpcionSeleccionada: (opcionSeleccionada: number) => void
  rolUsuario: number
}

export type IlistaPestanas = Record<number, Ipestanas[]>

const pestanas: IlistaPestanas = {
  1: pestanasEstudiante,
  2: pestanasDocente,
  3: pestanasAdministrativo
}

const Menu: React.FC<ImenuProps> = ({ setOpcionSeleccionada, rolUsuario }) => {
  let contadorSubpaneles = 0
  const location = useLocation()

  const seleccionarOpcion = (contadorSubpaneles: number): void => {
    setOpcionSeleccionada(contadorSubpaneles)
  }

  return (
    <IonMenu
      disabled={location.pathname === '/portal/login'}
      contentId='main'
      type='overlay'
    >
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
              <IonItem className='ion-margin-horizontal' lines='full'>
                <IonSelect
                  placeholder='Selecciona tu programa'
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
                onClick={() => {
                  seleccionarOpcion(1)
                }}
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
                {pestanas[rolUsuario].map((pagina, index) => {
                  return (
                    <IonAccordion
                      key={index}
                      className='accordion margenVertical'
                    >
                      <IonItem slot='header' color='light' lines='none'>
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
                        contadorSubpaneles += 1

                        return (
                          <IonItem
                            key={index}
                            onClick={() => {
                              seleccionarOpcion(contadorSubpaneles)
                            }}
                            className='ion-margin'
                            slot='content'
                            lines='full'
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
              <IonButton
                routerLink='/portal/login'
                className='button'
                expand='block'
              >
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
