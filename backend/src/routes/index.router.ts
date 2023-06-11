import express from 'express'
import { manejadorDeConsultas } from '../controller/query.handler'
const Router = express.Router()

Router.route('/api').all(manejadorDeConsultas)

export { Router }
