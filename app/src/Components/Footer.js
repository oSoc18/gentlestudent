import React, { Component } from 'react';
import grayLogo from './../assets/logo-gray.svg';

class Footer extends Component {
    render() {
        return (
            <footer>
                <div className="container">
                    <div className="content">
                        <ul className="first">
                            <li><a href="#">Leerkansen</a></li>
                            <li><a href="#">Word Issuer</a></li>
                            <li><a href="#">Over ons</a></li>
                            <li><a href="#">Nieuws</a></li>
                            <li><a href="#">Ervaringen</a></li>
                            <li><a href="#">Inloggen</a></li>
                            <li><a href="#">Registreer</a></li>
                            <li><a href="#">Help</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Sitemap</a></li>
                        </ul>
                        <div className="footer_bottom">
                            <img src={grayLogo} id="gray-logo" alt="logo" />
                            <div>
                                <ul className="bottom">
                                    <li><a href="#">GDPR-beleid</a></li>
                                    <li><a href="#">Cookiebeleid</a></li>
                                    <li><a href="#">Voorwaarden</a></li>
                                    <li><a href="#">Privacy</a></li>
                                    <li><a href="#">NL <i className="fas fa-caret-down"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        );
    }
}
  
export default Footer;