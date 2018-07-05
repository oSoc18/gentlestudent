import express from 'express';

import LeerkansController from './controllers/leerkansController';

export default class ApiV1Routes {
	constructor () {
		this.router = new express.Router();
		this.initStartRoute();
		this.initLeerkansRoutes();
	}
	initStartRoute () {
		this.router.get('/', (req, res) => {
			res.send(`
				<h1>Browse through our API</h1></br>
				<ul>
					<li>Leerkansen: <a href="/api/v1/leerkans">/api/v1/leerkans</a></li>
				</ul>
			`);
		});
	};
	initLeerkansRoutes () {
		this.router.get('/leerkans', (req, res) => {
			LeerkansController.get(req, res);
		});
		this.router.get('/leerkans/:_id', (req, res) => {
			LeerkansController.getById(req, res);
		});
		this.router.post('/leerkans', (req, res) => {
			LeerkansController.post(req, res);
		});
	}

	getRouter () {
		return this.router;
	}

}