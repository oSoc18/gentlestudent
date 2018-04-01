import React, { Component } from 'react';
import Krook from '../assets/krook.png';
import DG2 from '../assets/DG2.svg';

class Leerkansen extends Component {
    render() {
        return (
            <div id="leerkansen">
                <div className="container">
                    <div className="content">
                        <h1>Leerkansen</h1>
                        
                        <div class="card-container">
                            <div class="card-item leerkans">
                                <img src={Krook} class="photo" alt="krook" />
                                <div style={{position: "relative"}}>
                                    <img src={DG2} class="badge" alt="DG2" />
                                    <h2>ICT-lessen in ‘De Krook’</h2>
                                    <div className="meta-data">
                                        <small>Juli-Sept 2018</small>
                                        <small>Sint-pietersplein 1, 9000 Gent</small>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    </p>
                                </div>
                            </div>

                            <div class="card-item leerkans">
                                <img src={Krook} class="photo" alt="krook" />
                                <div style={{position: "relative"}}>
                                    <img src={DG2} class="badge" alt="DG2" />
                                    <h2>ICT-lessen in ‘De Krook’</h2>
                                    <div className="meta-data">
                                        <small>Juli-Sept 2018</small>
                                        <small>Sint-pietersplein 1, 9000 Gent</small>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    </p>
                                </div>
                            </div>

                            <div class="card-item leerkans">
                                <img src={Krook} class="photo" alt="krook" />
                                <div style={{position: "relative"}}>
                                    <img src={DG2} class="badge" alt="DG2" />
                                    <h2>ICT-lessen in ‘De Krook’</h2>
                                    <div className="meta-data">
                                        <small>Juli-Sept 2018</small>
                                        <small>Sint-pietersplein 1, 9000 Gent</small>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    </p>
                                </div>
                            </div>
                            
                            <div class="card-item leerkans">4</div>
                            <div class="card-item leerkans">5</div>
                            <div class="card-item leerkans">6</div>  
                            <div class="card-item leerkans">7</div>
                            <div class="card-item leerkans">8</div>
                            <div class="card-item leerkans">9</div>  
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

export default Leerkansen;