import { IonIcon } from '@ionic/react'
import { createOutline } from 'ionicons/icons'
import type React from 'react'
import './ProfileDetail.css'

const DetallesPerfil: React.FC = () => (
  <div className='informacion-personal'>
    <div>
      <IonIcon icon={createOutline} />
      <span>Documento: 1115090873</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>Nombres: Jose Alejandro</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>Apellidos: Salazar Montoya</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>E-mail: jose.salazar@utp.edu.co</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>Telefono: 3101234456</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>Dirección: Carrera 1 Calle 2 # - 4</span>
    </div>
    <div>
      <IonIcon icon={createOutline} />
      <span>Estado: Activo</span>
    </div>
  </div>
)

export default DetallesPerfil
