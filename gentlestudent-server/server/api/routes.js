import express from 'express';
import ApiV1Routes from '../api/v1/routes';

export default class ApiRoutes {
	constructor () {
		this.router = new express.Router();

		this.initApiV1Routes();
	}

	initApiV1Routes () {
		this.router.use('/v1', new ApiV1Routes().getRouter());
	}

	getRouter () {
		return this.router;
	}

}