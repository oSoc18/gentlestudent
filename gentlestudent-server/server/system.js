import http from 'http';
import express from 'express';
import bodyParser from 'body-parser';
import morgan from 'morgan';
import cors from 'cors';
import mongoose from 'mongoose';

import Config from './config/config';
import Passport from './config/passport';
import Routes from './config/routes';

export default class System {

	constructor (appDirectory) {
		try {
			this.config = new Config();

			this.appDirectory = appDirectory;
			this.app = express();
			
			this.initSettings();
			this.initDB();
			this.initExpressMiddleware();
			this.initRoutes();
			this.start();
			
			return Promise.resolve(this);
		}
		catch(error) {
			return Promise.reject(error);
		}
	}

	initSettings () {
		this.app.set('json spaces', 40);
	}

	initDB () {
		// mongoose.connect('mongodb://localhost/gentlestudent'); //localhost
		const uri = 'mongodb://' + this.config.db_user + ':' + this.config.db_pass + '@' + 
					'cluster0-shard-00-00-ofbzr.mongodb.net:27017,' +
					'cluster0-shard-00-01-ofbzr.mongodb.net:27017,' +
					'cluster0-shard-00-02-ofbzr.mongodb.net:27017/gentlestudent?' +
					'ssl=true&replicaSet=Cluster0-shard-0&authSource=admin';
		const options = {
		useMongoClient: true
		};
		mongoose.connect(uri, options);
	}

	initExpressMiddleware () {
		this.app.use(morgan('dev'));
		this.app.use(bodyParser.urlencoded({ 'extended':'true' }));
		this.app.use(cors());
		this.app.use(bodyParser.json());
		this.app.use(bodyParser.json({ 'type': 'application/vnd.api+json' }));
	}

	initRoutes () {
		this.app.get('/', (req, res) => {
			res.send('<h1>Hi!</h1></br> Our API is located here: <a href="/api/v1/">/api/v1/</a>');
		});
		this.routes = new Routes(this.app);
	}

	start () {
		this.server = http.createServer(this.app);
		this.server.listen(process.env.PORT || this.config.server.port);
	}
}