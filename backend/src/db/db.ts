import { createPool } from 'mysql2/promise';
import {
  DB_HOST,
  DB_NAME,
  DB_PASSWORD,
  DB_USER,
  DB_PORT,
} from '../config/config';

export const pool = createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  port: Number(DB_PORT),
  database: DB_NAME,
});
