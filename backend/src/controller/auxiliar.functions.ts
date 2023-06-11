import type { Response } from 'express'
// import { pool } from '../db/db'
import type { Iresponse, Imysql2Error } from '../interfaces'

const sendResponse = (
  res: Response,
  status: number,
  message: string,
  error?: Imysql2Error,
  data?: any
): void => {
  let response: Iresponse = {
    success: status === 200,
    status,
    message
  }

  if (status === 200) {
    response = {
      success: true,
      data,
      status,
      message
    }
  } else if (status === 404) {
    response = {
      success: false,
      status,
      message,
      error
    }
  } else if (status === 500) {
    response = {
      success: false,
      status,
      message,
      error
    }
  }

  res.status(status).json(response)
}

// const saveUser = async (req: Request, res: Response): Promise<void> => {
//   res.status(200).json({ message: 'Welcome to hell' })
//   try {
//     const [rows] = await pool.query('SELECT * FROM users')
//     sendResponse(res, 200, '__', undefined, rows) // TODO:
//   } catch (error) {
//     sendResponse(res, 500, 'No se ha podido __', error as Imysql2Error) // TODO:
//   }
// }

export { sendResponse }
