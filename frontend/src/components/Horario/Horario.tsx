import {
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonCol,
  IonGrid,
  IonItem,
  IonLabel,
  IonList,
  IonNote,
  IonRow,
  IonTitle
} from '@ionic/react'
import type React from 'react'

const Horario: React.FC = () => {
  const horario = [
    {
      hora: '6:00',
      lunes: 'Asignatura1',
      martes: '',
      miercoles: '',
      jueves: '',
      viernes: '',
      sabado: '',
      domingo: ''
    },
    {
      hora: '7:00',
      lunes: '',
      martes: '',
      miercoles: '',
      jueves: '',
      viernes: '',
      sabado: '',
      domingo: ''
    },
    {
      hora: '8:00',
      lunes: 'Asignatura2',
      martes: '',
      miercoles: 'Asignatura1',
      jueves: '',
      viernes: '',
      sabado: '',
      domingo: ''
    }
    // Agregar las demás filas del horario aquí
  ]

  const asignaturas = [
    {
      codigo: 'M001',
      nombre: 'Matemáticas',
      grupo: 'Grupo A',
      profesor: 'Juan Pérez',
      correo: 'juan.perez@example.com',
      salon: 'S101',
      dia: 'Lunes',
      horario: '9:00 - 10:00',
      notas: [
        {
          actividad: 'Parcial 1',
          fecha: '2023-05-20',
          porcentaje: 33,
          nota: 5.0
        },
        {
          actividad: 'Parcial 2',
          fecha: '2023-05-20',
          porcentaje: 33,
          nota: 5.0
        }
      ]
    },
    {
      codigo: 'F002',
      nombre: 'Física',
      grupo: 'Grupo B',
      profesor: 'María Gómez',
      correo: 'maria.gomez@example.com',
      salon: 'S102',
      dia: 'Martes',
      horario: '10:00 - 11:00',
      notas: [
        {
          actividad: 'Parcial 1',
          fecha: '2023-05-20',
          porcentaje: 50,
          nota: 5.0
        },
        {
          actividad: 'Parcial 2',
          fecha: '2023-05-20',
          porcentaje: 50,
          nota: 5.0
        }
      ]
    }
    // Agregar más detalles de asignaturas aquí
  ]

  return (
    <>
      <IonTitle className='ion-text-center ion-margin-vertical'>
        ¡Bienvenido al portal estudiantil!
      </IonTitle>
      <IonGrid className='horario-grid'>
        <IonRow className='horario-header'>
          <IonCol size='2'>Hora</IonCol>
          <IonCol>Lunes</IonCol>
          <IonCol>Martes</IonCol>
          <IonCol>Miércoles</IonCol>
          <IonCol>Jueves</IonCol>
          <IonCol>Viernes</IonCol>
          <IonCol>Sábado</IonCol>
          <IonCol>Domingo</IonCol>
        </IonRow>
        {horario.map((fila, index) => (
          <IonRow className='horario-fila' key={index}>
            <IonCol size='2'>{fila.hora}</IonCol>
            <IonCol>{fila.lunes}</IonCol>
            <IonCol>{fila.martes}</IonCol>
            <IonCol>{fila.miercoles}</IonCol>
            <IonCol>{fila.jueves}</IonCol>
            <IonCol>{fila.viernes}</IonCol>
            <IonCol>{fila.sabado}</IonCol>
            <IonCol>{fila.domingo}</IonCol>
          </IonRow>
        ))}
      </IonGrid>
      <div className='detalles-asignaturas'>
        <h2>Detalles de las asignaturas</h2>
        {asignaturas.map((asignatura, index) => (
          <IonCard className='asignatura-card' key={index}>
            <IonCardHeader>
              <IonCardTitle>
                {asignatura.codigo} - {asignatura.nombre} - {asignatura.grupo}
              </IonCardTitle>
              <IonCardSubtitle>Profesor: {asignatura.profesor}</IonCardSubtitle>
            </IonCardHeader>
            <IonCardContent>
              <IonCardSubtitle>Correo: {asignatura.correo}</IonCardSubtitle>
              <IonCardSubtitle>
                Salón: {asignatura.salon}, Día: {asignatura.dia}, Horario:{' '}
                {asignatura.horario}
              </IonCardSubtitle>
            </IonCardContent>
          </IonCard>
        ))}
      </div>
      <IonList className='notas-list'>
        {asignaturas.map((asignatura, index) => (
          <IonItem className='nota-asignatura' key={index}>
            <IonLabel>
              <h3>
                Codigo: {asignatura.codigo} - {asignatura.nombre} -{' '}
                {asignatura.grupo}
              </h3>
              {asignatura.notas.map((nota, notaIndex) => (
                <div key={notaIndex}>
                  <IonNote>Actividad: {nota.actividad}</IonNote>
                  <IonNote>Fecha Digitación: {nota.fecha}</IonNote>
                  <IonNote>Porcentaje: {nota.porcentaje}%</IonNote>
                  <IonNote>Nota: {nota.nota}</IonNote>
                </div>
              ))}
            </IonLabel>
          </IonItem>
        ))}
      </IonList>
    </>
  )
}

export default Horario
