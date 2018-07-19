import React, { Component } from 'react';
import Waypoint from 'react-waypoint';

import { cta, stepsIssuer } from './../Utils';
import { NavLink } from 'react-router-dom';

import step1 from './../../assets/step1.jpg';
import step2 from './../../assets/step2.jpg';
import step3 from './../../assets/step3.jpg';

import AuthUserContext from '../AuthUserContext';
import * as routes from '../../routes/routes';

class Steps extends Component {
	constructor(props) {
		super(props);

		this.state = {
			ctaFixed: 'fixed'
		};

		this.handleWaypointEnter = this.handleWaypointEnter.bind(this);
		this.handleWaypointLeave = this.handleWaypointLeave.bind(this);
	}
	handleWaypointEnter() {
		if (this.state.ctaFixed === 'fixed') {
			this.setState({ ctaFixed: '' });
		};
	}
	handleWaypointLeave() {
		if (this.state.ctaFixed === '') {
			this.setState({ ctaFixed: 'fixed' });
		};
	}

	render() {
		const { authUser } = this.state;
		return (
			<React.Fragment>
				<div className="container">
					<div className="content">
						<div id="steps-issuer">
							<h2>Hoe word ik een issuer?</h2>
						</div>
					</div>
				</div>
				<div {...stepsIssuer}>
					<div className="steps">
						{/* STEP 1 */}
						<div className="step">
							<div className="container">
								<span className="step-number">1</span>
								<div>
									<h3>Registreer als gebruiker</h3>
									<p>
										Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
									</p>
								</div>
								<img src={step1} alt="step1" height={150} width={270} />
							</div>
						</div>

						{/* STEP 2 */}
						<div className="step">
							<div className="container">
								<span className="step-number">2</span>
								<div>
									<h3>Registreer als issuer</h3>
									<p>
										Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus suscipit tortor eget felis porttitor volutpat.
									</p>
								</div>
								<img src={step2} alt="step2" height={150} width={270} />
							</div>
						</div>

						{/* STEP 3 */}
						<div className="step">
							<div className="container">
								<span className="step-number">3</span>
								<div>
									<h3>Wacht op goedkeuring</h3>
									<p>
										Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Cras ultricies ligula sed magna dictum porta.
									</p>
								</div>
								<img src={step3} alt="step3" height={150} width={270} />
							</div>
						</div>

						{/* CALL TO ACTION & WAYPOINT FIX */}
						<div id="waypoint-cta">
							<Waypoint
								onEnter={this.handleWaypointEnter}
								onLeave={this.handleWaypointLeave}
							/>
						</div>
						<div className={`cta ${this.state.ctaFixed}`} {...cta}>
							<AuthUserContext.Consumer>
								{authUser => authUser
									? <RegisterAuth ctaFixed={this.state.ctaFixed}/>
									: <RegisterNonAuth ctaFixed={this.state.ctaFixed}/>
								}
							</AuthUserContext.Consumer>
						</div>
					</div>
				</div>
			</React.Fragment>
		)
	}
}

const RegisterAuth = () =>
	<a href={routes.RegistreerIssuer} className="primary">Word Issuer</a>


const RegisterNonAuth = () =>
	<a href={routes.Register} className="primary">Word Issuer</a>


export default Steps;