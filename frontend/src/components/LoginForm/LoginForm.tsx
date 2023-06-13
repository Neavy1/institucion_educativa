import {
  CreateAnimation,
  IonAlert,
  IonButton,
  IonInput,
  IonItem,
  IonLabel
} from '@ionic/react'
import React, {
  Fragment,
  createRef,
  useCallback,
  useEffect,
  useState
} from 'react'
import './LoginForm.css'

// export interface IParametrosIniciarSesion {
//   setUsuarioRegistrado: (usuario: string) => void
// }

const IniciarSesion: React.FC = () => {
  const [usuario, setUsuario] = useState('')

  const formAnimation = createRef<CreateAnimation>()

  useEffect(() => {
    if (formAnimation.current !== null) {
      const animate = async (): Promise<void> => {
        const formAnimated = formAnimation.current?.animation
        if (formAnimated != null && formAnimated !== undefined) {
          await formAnimated.play()
        }
      }
      animate().catch((error) => {
        console.log(error)
      })
    }
  }, [formAnimation])

  const iniciarSesion = useCallback(() => {
    if (usuario === '') {
      console.log('Compruebe los datos')
    } else {
      console.log(usuario)
    }
  }, [usuario])

  return (
    <Fragment>
      <IonAlert
        mode='ios'
        isOpen={true}
        animated
        // onDidDismiss={() => setShowAlert(false)}
        backdropDismiss={false}
        cssClass='alertClass'
        header='Error'
        message='El número de cédula ingresado no se encuentra registrado'
        buttons={['Aceptar']}
      />

      <CreateAnimation
        ref={formAnimation}
        duration={1300}
        fromTo={[
          {
            property: 'transform',
            fromValue: 'translateY(100px)',
            toValue: 'translateY(0px)'
          },
          { property: 'opacity', fromValue: '0', toValue: '1' }
        ]}
      >
        <IonItem
          color='none'
          style={{ width: '15rem', margin: 'auto' }}
          className='ion-margin-top'
        >
          <IonLabel
            color='primary'
            style={{ fontSize: '1.5rem' }}
            position='floating'
          >
            Usuario
          </IonLabel>
          <IonInput
            color='secondary'
            required
            type='text'
            clearInput
            value={usuario}
            // onIonChange={(e) => {
            //   if (e.detail.value !== '' && e.detail.value !== undefined) {
            //     setUsuario(e.detail.value ?? '')
            //   }
            // }}
          />
        </IonItem>
        <IonItem
          color='none'
          style={{ width: '15rem', margin: 'auto' }}
          className='ion-margin-top'
        >
          <IonLabel
            color='primary'
            style={{ fontSize: '1.5rem' }}
            position='floating'
          >
            Contraseña
          </IonLabel>
          <IonInput
            color='secondary'
            required
            type='text'
            clearInput
            value={usuario}
            // onIonChange={(e) => {
            //   if (e.detail.value !== '' && e.detail.value !== undefined) {
            //     setUsuario(e.detail.value ?? '')
            //   }
            // }}
          />
        </IonItem>

        <br />

        <IonButton
          style={{ margin: 'auto', maxWidth: '330px' }}
          size='large'
          expand='block'
          shape='round'
          fill='solid'
          color='primary'
          onClick={iniciarSesion}
        >
          Iniciar sesión
        </IonButton>
      </CreateAnimation>
    </Fragment>
  )
}

export default React.memo(IniciarSesion)
