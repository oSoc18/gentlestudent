import System from './server/system';
// const System = require('./server/system');

const server = new System(__dirname)
	.then(obj => {
		console.log(`Server runs on: http://localhost:${obj.config.server.port}`);
	})
	.catch(error => {
		console.log(error);
	});