import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import { LeerkansenFetch } from './../../actions/leerkansActions';

import Spinner from './../../Components/Spinner';
import LK12345 from './../../assets/leerkansen/LK12345.png';
import dg2 from './../../assets/dg2.svg';

class List extends Component {
	componentDidMount() {
	  this.props.fetchLeerkansen();
	}
	render() {
		return (
			<React.Fragment>
				<h1>
					Leerkansen - 
					<small><Link to="/create-leerkansen"> Create leerkans</Link></small>
				</h1>
				{ this.props.leerkansen.loading ? <Spinner /> : null }
				<div className="card-container">
				{
					this.props.leerkansen.items.map((lk, key) => {
						return(
							<a href={`/leerkansen/${lk._id}`} className={`card-item leerkans ${ lk.type }`} key={lk._id}>
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
				</div>
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
)(List);