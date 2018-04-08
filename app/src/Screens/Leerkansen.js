import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Maps from './../Components/Maps';

import LK12345 from './../assets/leerkansen/LK12345.png';
import dg2 from './../assets/dg2.svg';

// Google APi key: AIzaSyALLWUxYAWdEzUoSuWD8j2gVGRR05SWpe8

class Leerkansen extends Component {

    constructor(props) {
        super(props);
        this.state = {
            leerkansen: []
        }
    }
    componentWillMount() {
        fetch('https://gentlestudent-api.herokuapp.com/api/v1/leerkans')
          .then(res => res.json())
          .then(data => this.setState({ leerkansen: data }));
    }
    
    render() {
        const renderLeerkansen = this.state.leerkansen.map(lk => 
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
        )
        return (
            <div>
                <Nav/>
                <div className="content">
                    <h1>Leerkansen</h1>
                    <div id="leerkansen">
                        <div className="content-left">
                            <div className="card-container">
                                { renderLeerkansen }
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