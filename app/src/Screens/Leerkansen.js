import React, { Component } from 'react';
import axios from 'axios';
import Nav from './../Components/Nav';
import Footer from './../Components/Footer';
import Maps from './../Components/Maps';

import LK12345 from './../assets/leerkansen/LK12345.png';
import dg2 from './../assets/dg2.svg';

// Google APi key: AIzaSyALLWUxYAWdEzUoSuWD8j2gVGRR05SWpe8

class Leerkansen extends Component {
    state = {
        leerkansen: []
    }
    componentDidMount() {
        axios.get('http://localhost:8080/api/v1/leerkans')
          .then(res => {
            const leerkansen = res.data;
            this.setState({ leerkansen: leerkansen });
          })
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
                                { this.state.leerkansen.map(lk => 
                                    <a href="#" className={`card-item leerkans ${ lk.type }`}>
                                        <img src={LK12345} class="photo" alt="photo" />
                                        <div style={{position: "relative"}}>
                                            <img src={dg2} class="badge" alt={lk.badge} />
                                            <h2>{lk.title}</h2>
                                            <div className="meta-data">
                                                <small>{lk.start_date + ' - ' + lk.end_date}</small>
                                                <small>{lk.street + ' ' + lk.house_number + ', ' + lk.postal_code + ' ' + lk.city}</small>
                                            </div>
                                            <p>{lk.synopsis}</p>
                                        </div>
                                    </a>
                                )}
                            </div>
                        </div>

                        <div className="content-right">
                            <div className="content">
                                <Maps />
                            </div>
                        </div>
                    </div>
                </div>
                <Footer/>
            </div>
        )
    }
}

export default Leerkansen;