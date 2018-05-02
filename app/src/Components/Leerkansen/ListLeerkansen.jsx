import React, { Component } from 'react';
import { connect } from 'react-redux';
import { LeerkansenFetch } from './../../actions/leerkansActions';

import LK12345 from './../../assets/leerkansen/LK12345.png';
import dg2 from './../../assets/dg2.svg';

class ListLeerkansen extends Component {
    componentDidMount() {
      this.props.fetchLeerkansen();
    }
    render() {
        return (
            <React.Fragment>
                {
                    this.props.leerkansen.items.map((lk, key) => {
                        return(
                            <a href="/" className={`card-item leerkans ${ lk.type }`} key={lk._id}>
                                <img src={LK12345} className="photo" alt={lk.title} />
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
                    })
                }
            </React.Fragment>
        )
    }
}

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
)(ListLeerkansen);