import express from 'express';
// import { saveUser } from '../controller/auxiliar.functions';
import { addNewProgram } from '../controller/controller';
const Router = express.Router();

Router.route('/newprogram').post(addNewProgram);

Router.route('/almacenes/crearCuadre/:nombreAlmacen').post();

Router.route('/almacenes/:nombreAlmacen').post().put();

export { Router };
