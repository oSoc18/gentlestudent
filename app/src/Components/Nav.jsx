import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';

import SignOutButton from './Auth/Logout';

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
			{ authUser
				? <NavigationAuth />
				: <NavigationNonAuth />
			}
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

const NavigationAuth = () =>
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
			<SignOutButton />
		</li>
	</React.Fragment>
</ul>


export default Navigation;
