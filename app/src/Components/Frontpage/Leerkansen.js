import React, { Component } from 'react';
import LK12345 from './../../assets/leerkansen/LK12345.png';
import LK12346 from './../../assets/leerkansen/LK12346.png';
import LK12347 from './../../assets/leerkansen/LK12347.png';
import dg2 from './../../assets/dg2.svg';
import dzh3 from './../../assets/dzh3.svg';
import ons1 from './../../assets/ons1.svg';

class Leerkansen extends Component {
    renderLeerkans (id, badge, type, level, title, synopsis, startDate, endDate, year, address) {
        function slugify(str) {
            return str.toString().toLowerCase()
                .replace(/\s+/g, '-')            // Replace spaces with -
                .replace(/[^\w\-]+/g, '')        // Remove all non-word chars
                .replace(/\-\-+/g, '')           // Replace multiple - with single -
                .replace(/^-+/, '')              // Trim - from start of text
                .replace(/-+$/, '');             // Trim - from end of text
        }
        return(
            <a href="#" className={`card-item leerkans ${ type }`}>
                <img src={id} class="photo" alt="photo" />
                <div style={{position: "relative"}}>
                    <img src={badge} class="badge" alt={badge} />
                    <h2>{title}</h2>
                    <div className="meta-data">
                        <small>{startDate + ' - ' + endDate + ' ' + year}</small>
                        <small>{address}</small>
                    </div>
                    <p>{synopsis}</p>
                </div>
            </a>
        )
    }
    render() {
        return (
            <div id="leerkansen">
                <div className="container">
                    <div className="content">
                        <h1 className="uitgelicht">Leerkansen</h1>
                        
                        <div className="card-container">
                            { this.renderLeerkans (
                                LK12345, dg2, 'dg', 2, 'ICT-lessen in ‘De Krook’',
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                'Juli', 'Sept', 2018,
                                'Sint-pietersplein 1, 9000 Gent')
                            }

                            { this.renderLeerkans (
                                LK12346, dzh3, 'dzh', 3, 'Sorteren Kringwinkel',
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                'Juli', 'Sept', 2018,
                                'Sint-pietersplein 1, 9000 Gent')
                            }

                             { this.renderLeerkans (
                                LK12347, ons1, 'ons', 1, 'Bloed geven Rode Kruis',
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                'Juli', 'Sept', 2018,
                                'Sint-pietersplein 1, 9000 Gent')
                            }
                        </div>
                        <a class="meer" href="#">Meer leerkansen</a>
                    </div>
                </div>
            </div>
        )
    }
}

export default Leerkansen;