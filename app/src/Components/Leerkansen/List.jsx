import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from './../../Components/Spinner';

class List extends Component {
	render() {
		return (
			<React.Fragment>
				{/* { this.props.leerkansen.loading ? <Spinner /> : null } */}
				<div className="card-container leerkansen">
				{
					// this.props.leerkansen.items.map((lk, key) => {
					// 	return(
					// 		<a href={`/leerkansen/${lk._id}`} className={`card-item leerkans ${ lk.type }`} key={lk._id}>
					// 			<img src={lk.image ? `https://gentlestudent-api.herokuapp.com/leerkansen/${lk.image}` : null} className="photo" alt={lk.title} />
					// 			<div style={{position: "relative"}}>
					// 				<img src={`https://api.badgr.io/public/badges/${lk.badge}/image",`} className="badge" alt={lk.type + lk.level} />
					// 				<h2>{lk.title}</h2>
					// 				<div className="meta-data">
					// 					<small>{lk.start_date + ' - ' + lk.end_date}</small>
					// 					<small>{lk.street + ' ' + lk.house_number + ', ' + lk.postal_code + ' ' + lk.city}</small>
					// 				</div>
					// 				<p>{lk.synopsis}</p>
					// 			</div>
					// 		</a>
					// 	)
					// })
				}
				</div>
			</React.Fragment>
		)
	}
}

export default List;