import React, { Component } from 'react';
import { connect } from 'react-redux';

import { firestore } from '../Firebase';

import Spinner from '../Spinner';

class List extends Component {
	constructor(props) {
		super(props);
	
		this.state = {
		  opportunities: null,
		};
	  }
	
	componentDidMount() {
		firestore.onceGetLeerkansen().then(snapshot => {
				var res = new Object()
				snapshot.forEach(doc => {
					res[doc.id] = doc.data();
				  });
				this.setState(() => ({ opportunities: res }))
			})
		  	.catch(err => {
				console.log('Error getting documents', err);
		  	});
	}
	render() {
		const { opportunities } = this.state;

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
				<a href={`/leerkansen/${opportunities[key].addressId}`} className={`card-item leerkans ${ opportunities[key].category }`} key={opportunities[key].addressId}>
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
		<div className="card-container leerkansen">
			Leerkansen konden niet worden geladen.
		</div>
	</div>

export default List;