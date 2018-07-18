import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';

import logo from './../assets/logo.svg';

class Nav extends Component {
	componentDidMount() {
		// console.log(this.props.auth.user);
	}
	render() {
		// console.log(this.props.auth.user);
		return (
			<nav>
				<div className="nav-wrapper">
					<div className="logo">
						<NavLink to="/">
							<img src={logo} id="gs-logo" alt="logo" />
						</NavLink>
					</div>
					<div className="nav">
						<ul id="gs-nav">
							<li className="nav_item">
								<NavLink to="/leerkansen" activeClassName="active">Leerkansen</NavLink>
							</li>
							<li className="nav_item">
								<NavLink to="/word-issuer" activeClassName="active">Word Issuer</NavLink>
							</li>
							<li className="nav_item">
								<NavLink to="/ervaringen">Ervaringen</NavLink>
							</li>
							<li className="nav_item">
								<NavLink to="/nieuws">Nieuws</NavLink>
							</li>
							<li className="nav_item">
								<NavLink to="/overons">Over ons</NavLink>
							</li>
							{/* {this.props.auth.user.username ? */}
								{/* <li className="nav_item">{this.props.auth.user.username}</li> : */}
								<React.Fragment>
									<li className="nav_item">
										<NavLink to="/login" className="primary">Login</NavLink>
									</li>
									<li className="nav_item primary">
										<NavLink to="/register" className="primary">Registreer</NavLink>
									</li>
								</React.Fragment>
							{/* } */}
							{/* <li className="nav_item language dropdown">
								<NavLink to="/">NL <i className="fas fa-caret-down"></i></NavLink>
							</li> */}
						</ul>
					</div>
				</div>
			</nav>
		);
	}
}


export default (Nav = connect(
  (state) => {
    return {
			auth: state.auth
		};
  },
  (dispatch) => {
    return {};
  }
)(Nav));
