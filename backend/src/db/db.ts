import { createPool } from 'mysql2/promise'
import {
  DB_HOST,
  DB_NAME,
  DB_PASSWORD,
  DB_PORT,
  DB_USER
} from '../config/config'

export const db = createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  port: Number(DB_PORT),
  database: DB_NAME
})
