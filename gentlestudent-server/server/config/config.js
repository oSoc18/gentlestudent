import joi from 'joi';
require('dotenv').config();

export default class Config {

	constructor () {
		this.createJoiSchema();
		this.createEnvVariables();
	}

	createJoiSchema () {
		this.envVarsSchema = joi.object({
			NODE_ENV: joi.string()
				.allow(['development', 'production', 'test'])
				.required(),
			PORT: joi.number()
				.default(8080),
				// .required(),
			LOGGER_LEVEL: joi.string()
				.allow(['error', 'warn', 'info', 'verbose', 'debug'])
				.default('info'),
			LOGGER_ENABLED: joi.boolean()
				.truthy('TRUE')
				.truthy('true')
				.falsy('FALSE')
				.falsy('false')
				.default(true)
		}).unknown()
			.required()
	}

	createEnvVariables () {
		const { error, value: envVars } = joi.validate(process.env, this.envVarsSchema)
		if (error) {
			throw new Error(`Config validation error: ${error.message}`)
		}

		this.env = envVars.NODE_ENV;
		this.isTest = envVars.NODE_ENV === 'test';
		this.isDevelopment = envVars.NODE_ENV === 'development';
		this.logger = {
			level: envVars.LOGGER_LEVEL,
			enabled: envVars.LOGGER_ENABLED
		};
		this.server = {
			port: envVars.PORT
		}
		this.db_user = process.env.DB_USER;
		this.db_pass = process.env.DB_PASSWORD;
	}

}