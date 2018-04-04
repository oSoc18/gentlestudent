import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

class Leerkansen extends Component {
    render() {
        return (
            <div>
                <Nav/>
                <div className="content">
                    <div id="leerkansen">
                        <h1>Leerkansen</h1>
                    </div>
                </div>
                <Footer/>
            </div>
        )
    }
}

export default Leerkansen;