import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';


import AuthUserContext from './AuthUserContext';
import SignOutButton from './Auth/Logout';
import { auth } from './Firebase';

import logo from './../assets/logo.svg';

import * as routes from '../routes/routes';

const Navigation = ({ authUser }) =>
	<nav>
	<div className="nav-wrapper">
		<div className="logo">
			<NavLink to="/">
				<img src={logo} id="gs-logo" alt="logo" />
			</NavLink>
		</div>
		<div className="nav">
		<AuthUserContext.Consumer>
			{authUser => authUser
				? <NavigationAuth />
				: <NavigationNonAuth />
			}
		</AuthUserContext.Consumer>
		</div>
	</div>
	</nav>

const NavigationNonAuth = () =>
	<ul id="gs-nav">
		<li className="nav_item">
			<NavLink to={routes.Leerkansen} activeClassName="active">Leerkansen</NavLink>
		</li>
		<li className="nav_item">
			<NavLink to={routes.WordIssuer} activeClassName="active">Word Issuer</NavLink>
		</li>
		<li className="nav_item">
			<NavLink to={routes.Ervaringen}>Ervaringen</NavLink>
		</li>
		<li className="nav_item">
			<NavLink to={routes.Nieuws}>Nieuws</NavLink>
		</li>
		<li className="nav_item">
			<NavLink to={routes.OverOns}>Over ons</NavLink>
		</li>
		<React.Fragment>
				<li className="nav_item">
					<NavLink to={routes.Login} className="primary">Login</NavLink>
				</li>
				<li className="nav_item primary">
					<NavLink to={routes.Register} className="primary">Registreer</NavLink>
				</li>
		</React.Fragment>
	</ul>

class NavigationAuth extends Component{
	constructor() {
		super();
		
		this.state = {
			showMenu: false,
		};
		
		this.showMenu = this.showMenu.bind(this);
		this.closeMenu = this.closeMenu.bind(this);
	}
	
	showMenu(event) {
		event.preventDefault();
		
		this.setState({ showMenu: true }, () => {
			document.addEventListener('click', this.closeMenu);
		});
	}
	
	closeMenu(event) {
		if (!this.dropdownMenu.contains(event.target)) {
			
			this.setState({ showMenu: false }, () => {
			document.removeEventListener('click', this.closeMenu);
			});  
			
		}
	}

	render() {
		return (
			<ul id="gs-nav">
				<li className="nav_item">
					<NavLink to={routes.Leerkansen} activeClassName="active">Leerkansen</NavLink>
				</li>
				<li className="nav_item">
					<NavLink to={routes.WordIssuer} activeClassName="active">Word Issuer</NavLink>
				</li>
				<li className="nav_item">
					<NavLink to={routes.Ervaringen}>Ervaringen</NavLink>
				</li>
				<li className="nav_item">
					<NavLink to={routes.Nieuws}>Nieuws</NavLink>
				</li>
				<li className="nav_item">
					<NavLink to={routes.OverOns}>Over ons</NavLink>
				</li>
				<React.Fragment>
				<li className="nav_item dropdown">
					<div>
						<button onClick={this.showMenu}>
							Show menu
						<i className="fas fa-caret-down"></i></button>
						
						{
							this.state.showMenu
							? (
								<div
									className="menu"
									ref={(element) => {
										this.dropdownMenu = element;
									}}
									>
									<NavLink to={routes.Profiel}>Profiel</NavLink>
									<NavLink to={routes.AangemaakteLeerkansen}>Aangemaakte leerkansen</NavLink>
									<NavLink to={routes.MaakLeerkans}>Maak leerkans</NavLink>
									<NavLink to={routes.ValideerIssuer}>Valideer issuer</NavLink>
									<NavLink to={routes.ValideerLeerkans}>Valideer leerkans</NavLink>
								</div>
							)
							: (
								null
							)
						}
					</div>
					
				</li>
				<li className="nav_item primary">
					<a className="primary" href={routes.Login}
						onClick={auth.doSignOut}
					>
						Log uit
					</a>
				</li>
				</React.Fragment>
			</ul>
		);
	}
}


export default Navigation;
