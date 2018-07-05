import Leerkans, { getLeerkanses, getLeerkansById } from './../models/leerkans';

export default class LeerkansController {
	constructor () {}
	
	static get(request, response) {
		getLeerkanses((err, leerkanses) => {
			if(err) throw err;
			response.json(leerkanses);
		}, 100); // limit 100
	}

	static getById (req, res) {
		getLeerkansById(req.params._id, (err, leerkans) => {
			if(err) throw err;
			res.json(leerkans);
		})
	}

	static post(request, response) {
		const leerkans = new Leerkans(request.body);
		leerkans.save()
			.then(item => {
				response.send("Leerkans toegevoegd.");
			})
			.catch(err => {
				response.status(400).send("Unable to save to the database.");
			});
	}
}