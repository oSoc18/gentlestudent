import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

class List extends Component {
	constructor(props) {
		super(props);
	
		this.state = {
		};
		this.getParticipations = this.getParticipations.bind(this);
	  }
	componentDidMount() {
		Object.keys(opportunities).map(key => this.getParticipations(key));
	}
	getParticipations(key){
		firestore.onceGetParticipationsForOpportunity(key).then(snapshot => {
			// console.log(JSON.stringify(snapshot.data()));
				if(this.props.opportunities[key]["participations"]){
					this.props.opportunities[key]["participations"]++
				}
				else{
					this.props.opportunities[key]["participations"]==1;
				}	
			})
			.catch(err => {
				console.log('Error getting documents', err);
			});
	}
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
	<div class="l-container">
	<ul>
		{Object.keys(opportunities).map(key =>
			<li class="list">
				<div class="list__opportunity_title">
					<div> <img src={opportunities[key].pinImageUrl ? `${opportunities[key].pinImageUrl}` : null}/> </div>
					<div class="list__label">
						{/* <div class="list__label--header"> Leerkans </div> */}
						<div class="list__label--value"><h2> {opportunities[key].title}</h2> </div>
					</div>
				</div>
				<div class="list__opportunity_data">
					<div class="list__label">
						<div class="list__label--header"> Begindatum </div>
						<div class="list__label--value">{opportunities[key].beginDate}</div>
					</div>
					<div class="list__label">
						<div class="list__label--header"> Einddatum </div>
						<div class="list__label--value">{opportunities[key].endDate}</div>
					</div>
					<div class="list__label">
						<div class="list__label--header"> Aantal deelnemers </div>
						<div class="list__label--value">{opportunities[key].participations}</div>
					</div>
					<div class="list__label">
						<div class="list__label--header"> Status </div>
						{!!opportunities[key].blocked && <div class="list__label--value">In afwachting</div>}
						{!opportunities[key].blocked && <div class="list__label--value">Geaccepteerd</div>}
					</div>
				</div>
			</li>
			// <a href={`aangemaakte-leerkansen/${key}`} className={`card-item leerkans ${ opportunities[key].category }`} key={opportunities[key].addressId}>
			//     <img src={opportunities[key].oppImageUrl ? `${opportunities[key].oppImageUrl}` : null} className="photo" alt="" />
			//     <div style={{position: "relative"}}>
			//     <img src={`${opportunities[key].pinImageUrl}`} className="badge" alt="" />
			//     <h2>{opportunities[key].title}</h2>
			//     <div className="meta-data">
			//     <small>{opportunities[key].beginDate + ' - ' + opportunities[key].endDate}</small>
			//     {/* <small>{opportunities[key].street + ' ' + opportunities[key].house_number + ', ' + opportunities[key].postal_code + ' ' + opportunities[key].city}</small> */}
			//     </div>
			//     <p>{opportunities[key].shortDescription}</p>
			// 	<h2>Status: {opportunities[key].blocked ? `In afwachting` : `Geaccepteerd`}</h2>
			//     </div>
			// </a>
		)}
	</ul>
	</div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

export default List;