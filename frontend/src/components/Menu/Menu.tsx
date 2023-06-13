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
  IonList,
  IonMenu,
  IonMenuToggle,
  IonRow,
  IonTitle,
  IonToolbar
} from '@ionic/react'

import {
  archiveOutline,
  archiveSharp,
  heartOutline,
  heartSharp,
  mailSharp,
  paperPlaneOutline,
  paperPlaneSharp
} from 'ionicons/icons'
import { useLocation } from 'react-router-dom'
import image from '../../assets/img/logo.svg'
import './Menu.css'

interface AppPage {
  url: string
  iosIcon: string
  mdIcon: string
  titulo: string
  subpaneles: string[]
}

const paginasAplicacion: AppPage[] = [
  {
    titulo: 'Inicio',
    url: '/portal/Portal%20estudiantil',
    iosIcon: mailSharp,
    mdIcon: mailSharp,
    subpaneles: []
  },
  {
    titulo: 'Mis cursos',
    url: '/page/Outbox',
    iosIcon: paperPlaneOutline,
    mdIcon: paperPlaneSharp,
    subpaneles: ['Notas parciales', 'Asignaturas']
  },
  {
    titulo: 'Horario',
    url: '/page/Archived',
    iosIcon: archiveOutline,
    mdIcon: archiveSharp,
    subpaneles: ['Ver horario', 'Editar horario']
  },
  {
    titulo: 'Matrícula académica',
    url: '/page/Favorites',
    iosIcon: heartOutline,
    mdIcon: heartSharp,
    subpaneles: ['Pensum de mi programa', 'Historial académico', 'Mi progreso']
  }
]

const Menu: React.FC = () => {
  const location = useLocation()

  return (
    <IonMenu disabled={false} contentId='main' type='overlay'>
      <IonHeader>
        <IonToolbar>
          <IonGrid>
            <IonCol>
              <IonRow>
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

      <IonContent>
        <IonGrid>
          <IonRow>
            <IonAccordionGroup>
              <IonAccordion className='accordion'>
                <IonItem slot='header' color='light'>
                  <IonLabel>Ingeniería de sistemas</IonLabel>
                </IonItem>
                <div className='ion-padding' slot='content'>
                  Ingeniería Industrial
                </div>
              </IonAccordion>
            </IonAccordionGroup>
          </IonRow>
          <IonRow>
            <IonCol>
              <IonList id='menu-options'>
                {paginasAplicacion.map((appPage, index) => {
                  return (
                    <IonMenuToggle key={index} autoHide={false}>
                      <IonItem
                        className={
                          location.pathname === appPage.url
                            ? 'selected ion-margin-vertical'
                            : 'ion-margin-vertical'
                        }
                        routerLink={appPage.url}
                        routerDirection='none'
                        lines='none'
                        detail={false}
                      >
                        <IonIcon
                          slot='start'
                          ios={appPage.iosIcon}
                          md={appPage.mdIcon}
                        />
                        <IonLabel>{appPage.titulo}</IonLabel>
                      </IonItem>
                    </IonMenuToggle>
                  )
                })}
              </IonList>
            </IonCol>
          </IonRow>
          <IonRow class='logout'>
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
