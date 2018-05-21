import React, { Component } from 'react';
import { Link } from "react-router-dom";

import Nav from './../Components/Nav.jsx';
import ListLeerkansen from './../Components/Leerkansen/ListLeerkansen.jsx';
import Maps from './../Components/Leerkansen/Maps.jsx';

class Leerkansen extends Component {
    render() {
        return (
            <div>
                <Nav/>
                <div className="content">
                    <h1>
                        Leerkansen - 
                        <small><Link to="/create-leerkansen"> Create leerkans</Link></small>
                    </h1>
                    <div id="leerkansen">
                        <div className="content-left">
                            <ListLeerkansen />
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