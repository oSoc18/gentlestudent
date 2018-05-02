import React, { Component } from 'react';

import Nav from './../Components/Nav.jsx';
import ListLeerkansen from './../Components/Leerkansen/ListLeerkansen.jsx';
import Maps from './../Components/Leerkansen/Maps.jsx';

class Leerkansen extends Component {
    constructor() {
        super();
    }
    render() {
        return (
            <div>
                <Nav/>
                <div className="content">
                    <h1>Leerkansen</h1>
                    <div id="leerkansen">
                        <div className="content-left">
                            <div className="card-container">
                                <ListLeerkansen />
                            </div>
                        </div>

                        <div className="content-right">
                            <div className="content">
                                <Maps />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

export default Leerkansen;