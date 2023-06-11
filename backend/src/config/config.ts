import { config } from 'dotenv'
config()
//TODO: retirar los parámetros locales para producción
export const PORT = process.env.PORT ?? 3000
export const NODE_ENV = process.env.NODE_ENV ?? 'dev'
export const DB_HOST = process.env.DB_HOST ?? 'localhost'
export const DB_USER = process.env.DB_USER ?? 'root'
export const DB_PASSWORD = process.env.DB_PASSWORD ?? 'password'
export const DB_NAME = process.env.DB_NAME ?? 'institucion_educativa'
export const DB_PORT = process.env.DB_PORT ?? 3306
export const SALT_ROUNDS = process.env.SALT_ROUNDS ?? 10
