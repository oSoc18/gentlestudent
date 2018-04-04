import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

class Nieuws extends Component {
    render() {
        return (
            <div>
                <Nav/>
                    <div className="container">
                        <div className="content">
                            <h1>Nieuws</h1>
                        </div>
                    </div>
                <Footer/>
            </div>
        )
    }
}

export default Nieuws;