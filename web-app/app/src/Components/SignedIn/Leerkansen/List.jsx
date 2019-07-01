import React, { Component } from 'react';

import Spinner from '../../../Shared/Spinner';

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
					<div className="crop-opp-img">
						<img src={opportunities[key].oppImageUrl ? `${opportunities[key].oppImageUrl}` : null} className="photo" alt="" />
					</div>
					<div style={{position: "relative"}}>
					<img src={`${opportunities[key].pinImageUrl}`} className="badge" alt="" />
					<h2>{opportunities[key].title}</h2>
					<div className="meta-data">
					<small>{opportunities[key].beginDate + ' tot ' + opportunities[key].endDate}</small>
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