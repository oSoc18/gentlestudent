import React, { Component } from 'react';
import grayLogo from './../assets/logo-gray.svg';
import * as routes from '../routes/routes.js';

class Footer extends Component {
    render() {
        return (
            <footer>
                <div className="container footer">
                    <div className="content">
                        <ul className="first">
                            <li><a href={routes.Leerkansen}>Leerkansen</a></li>
                            <li><a href={routes.WordIssuer}>Word Issuer</a></li>
                            <li><a href={routes.OverOns}>Over ons</a></li>
                            <li><a href={routes.Nieuws}>Nieuws</a></li>
                            <li><a href={routes.Ervaringen}>Ervaringen</a></li>
                            <li><a href={routes.Login}>Inloggen</a></li>
                            <li><a href={routes.Register}>Registreer</a></li>
                            {/* <li><a href={routes.}>Help</a></li> */}
                            {/* <li><a href={routes.}>Contact</a></li> */}
                            {/* <li><a href={routes.}>Sitemap</a></li> */}
                        </ul>
                        <div className="footer_bottom">
                            <img src={grayLogo} id="gray-logo" alt="logo" />
                            <div>
                                <ul className="bottom">
                                    {/* <li><a href="/">GDPR-beleid</a></li> */}
                                    {/* <li><a href="/">Cookiebeleid</a></li> */}
                                    <li><a href={routes.Voorwaarden}>Voorwaarden</a></li>
                                    <li><a href={routes.Privacy}>Privacy</a></li>
                                    {/* <li><a href="/">NL <i className="fas fa-caret-down"></i></a></li> */}
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