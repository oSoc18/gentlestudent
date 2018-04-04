import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

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