import express from 'express'
import {
  type Application,
  type Request,
  type Response,
  type NextFunction
} from 'express'
import path from 'path'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import cors from 'cors'

import { Router } from './routes/index.router'
import { NODE_ENV, PORT } from './config/config'
import { sendResponse } from './controller/auxiliar.functions'

const app: Application = express()

// view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'pug')

// Middleware
app.use(cors())
app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

// Routes
app.use('/api', Router)

// catch 404 and forward to error handler
app.use((req: Request, res: Response, next: NextFunction) => {
  sendResponse(res, 404, 'Error, ruta no encontrada')
})

// error handler
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}

  // render the error page
  res.status(err.status ?? 500)
  res.render('error')
})

app.listen(PORT)
console.log(`Server on port: ${PORT}`)
console.log(`Node env: ${NODE_ENV}`)

export default app
