export const errores: Record<number, string> = {
  0: 'Hubo un error en la consulta a la base de datos',
  1: 'Error, ruta no encontrada',
  2: 'El número de la consulta ingresado es inválido',
  3: 'No ha introducido todos los parámetros necesarios para ejecutar la consulta deseada',
  4: 'Error al generar el hash para la contraseña',
  5: 'Contraseña incorrecta',
  6: 'No existe una función para procesar el número de consulta introducido',
  7: 'Usuario no encontrado',
  1062: 'Entrada duplicada, los valores que intentas insertar ya existen',
  1452: 'Error de llave foránea: los datos que intentas agregar no existen en la tabla referenciada',
  1064: 'Error de sintaxis en la consulta'
}

export const mensajesUsuario: Record<number, string> = {
  0: 'Consulta exitosa',
  1: 'Consulta exitosa pero no se alteró ningún registro',
  2: 'Consulta exitosa pero no se encontro ningún resultado en la base de datos',
  3: 'La contraseña del usuario ha sido cambiada exitosamente'
}
