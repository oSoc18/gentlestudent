import express from 'express';
import ApiRoutes from '../api/routes';

export default class Routes {
	
	constructor (app) {
		this.app = app;
		this.router = new express.Router();

		this.initApiRoutes();
		
	}

	initApiRoutes () {
		this.app.use('/api', new ApiRoutes().getRouter());
	}

}