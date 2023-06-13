import { App as CapacitorApp } from '@capacitor/app'
import {
  IonApp,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact
} from '@ionic/react'
import { IonReactRouter } from '@ionic/react-router'
import { useEffect } from 'react'
import { Redirect, Route } from 'react-router-dom'
import Portal from './pages/Portal/Portal'

/* Core CSS required for Ionic components to work properly */
import '@ionic/react/css/core.css'

/* Basic CSS for apps built with Ionic */
import '@ionic/react/css/normalize.css'
import '@ionic/react/css/structure.css'
import '@ionic/react/css/typography.css'

/* Optional CSS utils that can be commented out */
import '@ionic/react/css/display.css'
import '@ionic/react/css/flex-utils.css'
import '@ionic/react/css/float-elements.css'
import '@ionic/react/css/padding.css'
import '@ionic/react/css/text-alignment.css'
import '@ionic/react/css/text-transformation.css'

/* Theme variables */
import Menu from './components/Menu/Menu'
import { autorizarInicioSesion } from './controller/api.methods'
import { roles } from './interfaces'
import './theme/variables.css'
setupIonicReact({
  animated: true
})

const App: React.FC = () => {
  useEffect(() => {
    CapacitorApp.addListener('backButton', ({ canGoBack }) => {
      //TODO canGoBack?
      if (canGoBack) {
        window.history.back()
      } else {
        if (
          window.location.pathname === '/' ||
          window.location.pathname === '/Login'
        ) {
          CapacitorApp.exitApp().catch((error) => {
            console.log(error)
          })
        }
      }
    }).catch((error) => {
      console.log(error)
    })

    autorizarInicioSesion({
      idUsuario: 1,
      contrasenaIngresada: 'pingo'
    })
      .then((aprobado) => {
        console.log(aprobado)
      })
      .catch((error) => {
        console.log(error)
      })
  }, [])

  return (
    <IonApp>
      <IonReactRouter>
        <IonSplitPane contentId='main'>
          <Menu />
          <IonRouterOutlet id='main'>
            <Route path='/' exact={true}>
              <Redirect to={`/portal/${roles.estudiante}`} />
            </Route>
            {/* <Route path='/portal/login' exact={true}>
              <IniciarSesion />
            </Route> */}
            <Route path={`/portal/${roles.estudiante}`} exact={true}>
              <Portal rolUsuario={roles.estudiante} />
            </Route>
            <Route path={`/portal/${roles.docente}`} exact={true}>
              <Portal rolUsuario={roles.docente} />
            </Route>
            <Route path={`/portal/${roles.administrativo}`} exact={true}>
              <Portal rolUsuario={roles.administrativo} />
            </Route>
          </IonRouterOutlet>
        </IonSplitPane>
      </IonReactRouter>
    </IonApp>
  )
}

export default App
