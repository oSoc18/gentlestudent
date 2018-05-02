import React, { Component } from 'react';

import Nav from './../Components/Nav.jsx';
import Footer from './../Components/Footer.jsx';

class Ervaringen extends Component {
    render() {
        return (
            <div>
                <Nav/>
                    <div className="container">
                        <div className="content">
                            <h1>Ervaringen</h1>
                        </div>
                    </div>
                <Footer/>
            </div>
        )
    }
}

export default Ervaringen;