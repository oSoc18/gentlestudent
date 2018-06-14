import React, { Component } from 'react';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

class OverOns extends Component {
    render() {
        return (
            <div>
                <Nav/>
                    <div className="container">
                        <div className="content">
                            <h1>Over Ons</h1>
                        </div>
                    </div>
                <Footer/>
            </div>
        )
    }
}

export default OverOns;