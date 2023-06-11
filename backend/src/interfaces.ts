import { type Request, type Response } from 'express'

export interface controller {
  getUsers?: (req: Request, res: Response) => void
}

export interface Iresponse {
  success: boolean
  status?: number
  message?: any
  data?: any
  error?: any
}
export interface Imysql2Error {
  message: string
  code: string
  errno: number
  sql: string
  sqlState: string
  sqlMessage: string
}
