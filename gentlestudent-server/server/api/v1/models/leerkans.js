const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const leerkansSchema = new Schema({
	title: {
		type: String,
		min: [6, 'Too short!'],
		max: 50,
		required: true
	},
	synopsis: {
		type: String,
		max: 200,
		required: true
	},
	description: {
		type: String,
		max: 1000,
		required: true
	},
	badge: {},
	type: {
		type: String,
		enum: [
			'dg',  // Digitale Geltterdheid
			'dzh', // Duurzaamheid
			'ons', // Ondernemerschapszin
			'ond', // Onderzoek
			'wbs'  // Wereldburgerschap
		],
		required: true
	},
	level: {
		type: String,
		enum: [1, 2, 3], // 1: Beginner, 2: Indermediate, 3: Expert
		required: true
	},
	start_date: {
		type: Date,
		required: true
	},
	end_date: {
		type: Date,
		required: true
	},
	coordinate: {
		type: Object,
		latitude: {
			type: String,
			required: true
		},
		longitude: {
			type: String,
			required: true
		}
	},
	street: {
		type: String,
		required: true
	},
	house_number: {
		type: Number,
		required: true
	},
	postal_code: {
		type: Number,
		required: true
	},
	city: {
		type: String,
		required: true
	},
	country: {
		type: String,
		required: true
	},
	issued: {
		type: Boolean,
		default: false
	},
	created_at: {
		type: Date,
		default: Date.now
	},
	updated_at: {
		type: Date,
		default: null
	},
	soft_deleted: {
		type: Boolean,
		default: false
	},
}, {
	versionKey: false
});

const Leerkans = module.exports = mongoose.model('leerkanses', leerkansSchema);

module.exports.getLeerkanses = (callback, limit) => {
	Leerkans
		.find(callback)
		.limit(limit);
};
module.exports.getLeerkansById = (id, callback) => {
	Leerkans.findById(id, callback);
};

