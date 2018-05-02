import React, { Component } from 'react';

import Nav from './../Components/Nav.jsx';
import Footer from './../Components/Footer.jsx';

class Template extends Component {
    render() {
        return (
            <div>
                <Nav/>
                    <div className="container">
                        <div className="content">
                            <h1>Template</h1>
                        </div>
                    </div>
                <Footer/>
            </div>
        )
    }
}

export default Template;