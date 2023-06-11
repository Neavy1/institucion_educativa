import express from 'express'
// import express, { type Request, type Response } from 'express'
// import { saveUser } from '../controller/auxiliar.functions';
import {
  listaAsignaturasProgramaAcademico,
  listaAsignaturasYCursosDeExtension,
  listaProgramasAcademicos
} from '../controller/query.handler'
const Router = express.Router()

Router.route('/programas_academicos/').get(listaProgramasAcademicos)

Router.route('/asignaturas_programa_academico/:idProgramaAcademico/').get(
  listaAsignaturasProgramaAcademico
)

Router.route('/asignaturas_y_cursos/').get(listaAsignaturasYCursosDeExtension)

export { Router }
