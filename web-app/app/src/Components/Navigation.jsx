import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';


import AuthUserContext from './AuthUserContext';
// import SignOutButton from './Auth/Logout';
import { auth, firestore } from './Firebase';

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
	constructor(props) {
		super(props);
		
		this.state = {
			name: "",
			participant: null,
			showMenu: false,
			userId: "",
			isIssuer: false,
			isAdmin: false
		};
		
		this.showMenu = this.showMenu.bind(this);
		this.closeMenu = this.closeMenu.bind(this);
	}

	componentDidMount() {
		let id = auth.getUserId()
		this.setState(() => ({ userId: id }))
		firestore.onceGetParticipant(id).then(doc => {
			var res = new Object();
			if(doc.data()){
				this.setState(() => ({ participant: doc.data() }));
				this.setState(() => ({ name: doc.data().name.split(" ")[0] }));
			}
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
		firestore.onceGetIssuer(id).then(doc => {
			if(doc.data()){
				if(doc.data().validated){
					this.setState(() => ({ isIssuer: true }));
				}
			}
		})
		.catch(err => {
			console.log('User is not an issuer', err);
		});
		firestore.onceGetAdmin(id).then(doc => {
			var res = new Object();
			if(doc.data()){
				this.setState(() => ({ isAdmin: true }));
			}
		})
		.catch(err => {
			console.log('User is not an admin', err);
		});
		// firestore.onceGetParticipant(AuthUserContext).then(snapshot => {
		// 	var res = new Object()
		// 	snapshot.forEach(doc => {
		// 		res[doc.id] = doc.data();
		// 	});
		// 	this.setState(() => ({ opportunities: res }))
		// })
		// .catch(err => {
		// 	console.log('Error getting documents', err);
		// });
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
		const { isAdmin, isIssuer } = this.state;

		return (
			<ul id="gs-nav">
				<li className="nav_item">
					<NavLink to={routes.Leerkansen} activeClassName="active">Leerkansen</NavLink>
				</li>
				{ ! isIssuer && <WordIssuer/> }
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
					<button className="nav_item primary" onClick={this.showMenu}>
						Welkom {this.state.name}!
					<i className="fas fa-caret-down"></i></button>
					
					{
						this.state.showMenu
						? (
							<div
								className="dropdown-menu"
								ref={(element) => {
									this.dropdownMenu = element;
								}}
								>
								<div className="dropdown-menu-list">
									<NavLink to={routes.Profiel}>Profiel</NavLink>
									{/* <div class="separator">-----------------</div> */}
									<div class="nav-dropdown-ext">
										{ !! isIssuer && <NavigationIssuer/>}
									</div>
									{/* <div class="separator">-----------------</div> */}
									<div class="nav-dropdown-ext">
										{ !! isAdmin && <NavigationAdmin/>}
									</div>
								</div>
							</div>
						)
						: (
							null
						)
					}
					
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

const WordIssuer = () =>
	<li className="nav_item">
		<NavLink to={routes.WordIssuer} activeClassName="active">Word Issuer</NavLink>
	</li>

const NavigationIssuer= () =>
	<React.Fragment>
		<NavLink to={routes.AangemaakteLeerkansen}>Aangemaakte leerkansen</NavLink>
		<NavLink to={routes.MaakLeerkans}>Maak leerkans</NavLink>
	</React.Fragment>

const NavigationAdmin = () =>
	<React.Fragment>
		<NavLink to={routes.ValideerIssuer}>Valideer issuer</NavLink>
		<NavLink to={routes.ValideerLeerkans}>Valideer leerkans</NavLink>
	</React.Fragment>

export default Navigation;
