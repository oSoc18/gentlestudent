import React, { Component } from 'react';
import logo from './../assets/logo.svg';

class Nav extends Component {
    render() {
        return (
            <nav>
                <div className="logo">
                    <a href="#">
                        <img src={logo} id="gs-logo" alt="logo" />
                    </a>
                </div>
                <div className="nav">
                    <ul id="gs-nav">
                        <li className="nav_item">
                            <a href="#">Leerkansen</a>
                        </li>
                        <li className="nav_item">
                        <a href="#">Word Issuer</a>
                        </li>
                        <li className="nav_item">
                            <a href="#">Ervaringen</a>
                        </li>
                        <li className="nav_item">
                            <a href="#">Nieuws</a>
                        </li>
                        <li className="nav_item">
                            <a href="#">Over ons</a>
                        </li>
                        <li className="nav_item">
                            <a href="#" className="primary">Login</a>
                        </li>
                        <li className="nav_item primary">
                            <a href="#" className="primary">Register</a>
                        </li>
                        <li className="nav_item language dropdown">
                            <a href="#">NL <i class="fas fa-caret-down"></i></a>
                        </li>
                    </ul>
                </div>
            </nav>
        );
    }
}
  
export default Nav;