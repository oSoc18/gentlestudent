import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

class List extends Component {
	render() {
		const { opportunities } = this.props;

		return (
			<React.Fragment>
				{ !! opportunities && <LeerkansenList opportunities={ opportunities } /> }
				{ ! opportunities && <EmptyList/> }
			</React.Fragment>
		)
	}
}

const LeerkansenList = ({ opportunities }) =>
	<div>
		<div className="card-container leerkansen">
			{Object.keys(opportunities).map(key =>
				<a href={`/leerkansen/${key}`} className={`card-item leerkans ${ opportunities[key].category }`} key={opportunities[key].addressId}>
					<img src={opportunities[key].oppImageUrl ? `https://gentlestudent-api.herokuapp.com/leerkansen/${opportunities[key].pinImageUrl}` : null} className="photo" alt={opportunities[key].title} />
					<div style={{position: "relative"}}>
					<img src={`https://api.badgr.io/public/badges/${opportunities[key].pinImageUrl}/image",`} className="badge" alt={opportunities[key].category + opportunities[key].difficulty} />
					<h2>{opportunities[key].title}</h2>
					<div className="meta-data">
					<small>{opportunities[key].beginDate + ' - ' + opportunities[key].endDate}</small>
					{/* <small>{opportunities[key].street + ' ' + opportunities[key].house_number + ', ' + opportunities[key].postal_code + ' ' + opportunities[key].city}</small> */}
					</div>
					<p>{opportunities[key].shortDescription}</p>
					</div>
				</a>
			)}
		</div>
	</div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

export default List;