import { CreateAnimation, IonContent, IonPage } from '@ionic/react'
import React, { createRef, useEffect } from 'react'
import logo from '../../assets/img/logo.svg'
import AnimatedName from '../../components/AnimatedName/AnimatedName'
import LoginForm from '../../components/LoginForm/LoginForm'
import './IniciarSesion.css'

export interface IiniciarSesionProps {
  setRolUsuario: (rolUsuario: number) => void
}

const IniciarSesion: React.FC<IiniciarSesionProps> = ({ setRolUsuario }) => {
  const logoAnimation = createRef<CreateAnimation>()
  const footerAnimation = createRef<CreateAnimation>()

  useEffect(() => {
    if (logoAnimation.current !== null && footerAnimation.current !== null) {
      const animate = async (): Promise<void> => {
        const logoAnimated = logoAnimation.current?.animation
        const footerAnimated = footerAnimation.current?.animation
        if (logoAnimated !== undefined) {
          await logoAnimated.play()
        }
        if (footerAnimated !== undefined) {
          await footerAnimated.play()
        }
      }
      animate().catch((error) => {
        console.log(error)
      })
    }
  }, [logoAnimation, footerAnimation])

  return (
    <IonPage>
      <IonContent className='bg-image'>
        <CreateAnimation
          ref={logoAnimation}
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
          <img className='logo' src={logo} alt='logo'></img>
        </CreateAnimation>

        <br />
        <br />
        <AnimatedName />
        <br />
        <LoginForm setRolUsuario={setRolUsuario} />
      </IonContent>

      <CreateAnimation
        ref={footerAnimation}
        duration={1300}
        fromTo={[
          {
            property: 'transform',
            fromValue: 'translateX(100px)',
            toValue: 'translateX(0px)'
          },
          { property: 'opacity', fromValue: '0', toValue: '1' }
        ]}
      ></CreateAnimation>
    </IonPage>
  )
}

export default React.memo(IniciarSesion)
