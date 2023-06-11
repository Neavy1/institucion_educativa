import { config } from 'dotenv'
config()

export const PORT = process.env.PORT ?? 3000
export const NODE_ENV = process.env.NODE_ENV ?? 'dev'
export const DB_HOST = process.env.DB_HOST ?? 'localhost'
export const DB_USER = process.env.DB_USER ?? 'root'
export const DB_PASSWORD = process.env.DB_PASSWORD ?? 'password'
export const DB_NAME = process.env.DB_NAME ?? 'institucion_educativa'
export const DB_PORT = process.env.DB_PORT ?? 3306
export const SALT_LENGTH = process.env.SALT_LENGTH ?? 16
export const ENCODING_BUFFER = process.env.ENCODING_BUFFER ?? 'hex'
export const HASH_ALGORITHM = process.env.HASH_ALGORITHM ?? 'sha256'
