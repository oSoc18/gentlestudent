import React, { Component } from 'react';
// import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { LeerkansenFetch } from './../actions/leerkansActions';

import Nav from './../Components/Nav';
import Maps from './../Components/Leerkansen/Maps';

import LK12345 from './../assets/leerkansen/LK12345.png';
import dg2 from './../assets/dg2.svg';

class Leerkansen extends Component {
    componentDidMount() {
        this.props.fetchLeerkansen();
    }
    
    render() {
        const renderLeerkansen = 
            this.props.leerkansen.items.map(lk => {
                return(
                    <a href="/" className={`card-item leerkans ${ lk.type }`} key={lk._id}>
                        <img src={LK12345} className="photo" alt="photo" />
                        <div style={{position: "relative"}}>
                            <img src={dg2} className="badge" alt={lk.badge} />
                            <h2>{lk.title}</h2>
                            <div className="meta-data">
                                <small>{lk.start_date + ' - ' + lk.end_date}</small>
                                <small>{lk.street + ' ' + lk.house_number + ', ' + lk.postal_code + ' ' + lk.city}</small>
                            </div>
                            <p>{lk.synopsis}</p>
                        </div>
                    </a>
                )
            });
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

// Leerkansen.propTypes = {
// 	fetchLeerkansen: PropTypes.func.isRequired,
// 	leerkansen: PropTypes.array.isRequired
// }

// const mapStateToProps = state => ({
// 	leerkansen: state.leerkansen.items
// })

export default connect(
    (state) => {
        return {
            leerkansen: state.leerkansen
        };
    },
    (dispatch) => {
        return {
            fetchLeerkansen: () => {
                dispatch(LeerkansenFetch());
            }
        }
    }
)(Leerkansen);