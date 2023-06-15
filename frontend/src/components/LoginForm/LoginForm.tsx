import {
  CreateAnimation,
  IonAlert,
  IonButton,
  IonInput,
  IonItem,
  IonLabel,
  IonSelect,
  IonSelectOption
} from '@ionic/react'
import React, { Fragment, createRef, useEffect } from 'react'
import './LoginForm.css'

// export interface IParametrosIniciarSesion {
//   setUsuarioRegistrado: (usuario: string) => void
// }

export interface LoginFormProps {
  setRolUsuario: (rolUsuario: number) => void
}

export type Irutas = Record<number, string>

const rutas: Irutas = {
  1: '/portal/estudiante',
  2: '/portal/docente',
  3: '/portal/administrativo'
}

const LoginForm: React.FC<LoginFormProps> = ({ setRolUsuario }) => {
  let rolSeleccionado: number = 1

  const styles = {
    minWidth: 'fit-content',
    paddingRight: '1.5%'
  }

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
        <IonItem style={{ width: '17rem', margin: 'auto' }}>
          <IonSelect
            label='Selecciona un rol'
            interface='popover'
            mode='ios'
            style={styles}
            // slot='end'
            value={1}
            onIonChange={(e) => {
              setRolUsuario(e.detail.value as number)
              rolSeleccionado = e.detail.value as number
            }}
          >
            <IonSelectOption value={1}>Estudiante</IonSelectOption>
            <IonSelectOption value={2}>Docente</IonSelectOption>
            <IonSelectOption value={3}>Administrativo</IonSelectOption>
          </IonSelect>
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
            Usuario
          </IonLabel>
          <IonInput
            color='secondary'
            required
            type='text'
            clearInput
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
          routerLink={rutas[rolSeleccionado]}
          color='primary'
        >
          Iniciar sesión
        </IonButton>
      </CreateAnimation>
    </Fragment>
  )
}

export default React.memo(LoginForm)
