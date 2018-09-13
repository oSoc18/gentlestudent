import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';
import * as routes from '../../routes/routes';

import { firestore } from './../Firebase';

import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css'

class List extends Component {
	constructor(props) {
        super(props);

        this.state = {};
      };
	render() {
		const { opportunities, getOpportunities } = this.props;

		return (
			<React.Fragment>
				{ !! opportunities && Object.keys(opportunities).length!=0 && <LeerkansenList opportunities={ opportunities } getOpportunities={getOpportunities}/> }
				{ !! opportunities && Object.keys(opportunities).length==0 && <EmptyList/> }
				{ ! opportunities && <LoadingList/> }
			</React.Fragment>
		)
	}
}

class LeerkansenList extends Component {
	constructor(props){
		super(props);

		this.state = {};
	}
	confirmDelete = (event) => {
		var click = event.target;
		confirmAlert({
			customUI: ({ onClose }) => {
				return (
				<div className='confirm-delete'>
					<h1>Verwijder leerkans?</h1>
					<p>Ben je zeker dat je deze leerkans wenst te verwijderen?</p>
					<div class="content">
						<div class="content-left">
							<button onClick={() => {
								this.handleClickDelete(click);
								onClose()
							}}><b>Ja</b></button>
						</div>
						<div class="content-right">
							<button onClick={onClose}><b>Nee</b></button>
						</div>
					</div>
				</div>
				)
			}
		})
	  };
	handleClickDelete(eventTarget){
		// console.log(eventTarget.id);
		var self = this;
		firestore.softDeleteOpportunity(eventTarget.id).then((res) =>
			{self.props.getOpportunities();}
		)
		.catch(err => {
			console.log('Error soft deleting opportunity: ', err);
		});
	}
	render(){
		const { opportunities } = this.props;
		return(
			<div class="l-container">
			<ul>
				{Object.keys(opportunities).map(key =>
					<a href={`aangemaakte-leerkansen/${key}`}>
					<li class="list">
						<div class="list__opportunity_title">
							<div> <img src={opportunities[key].pinImageUrl ? `${opportunities[key].pinImageUrl}` : null}/> </div>
							<div class="list__label">
								{/* <div class="list__label--header"> Leerkans </div> */}
								<div class="list__label--value"><h2> {opportunities[key].title}</h2> </div>
							</div>
						</div>
						<div class="filler"/>
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
								{!!(opportunities[key].authority==0) && <div class="list__label--value">In afwachting</div>}
								{!(opportunities[key].authority==0) && <div class="list__label--value">Geaccepteerd</div>}
							</div>
						</div>
						{/* <div class="filler"/> */}
						{!!(opportunities[key].authority==0) && <a href="#"><div class="edit icon-container"><i class="fas fa-edit fa-2x"></i></div></a>}
						<a href="#" onClick={this.confirmDelete}><div class="delete icon-container"><i class="fas fa-trash-alt fa-2x" id={key}></i></div></a>
						<a href={routes.MaakLeerkans+"/"+key}><div class="copy icon-container"><i class="fas fa-plus fa-2x"></i></div></a>
					</li>
					</a>
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
					// 	<h2>Status: {(opportunities[key].authority==0) ? `In afwachting` : `Geaccepteerd`}</h2>
					//     </div>
					// </a>
				)}
			</ul>
			</div>
		)
	}
}

// const LeerkansenList = ({ opportunities }) =>
// 	<div class="l-container">
// 	<ul>
// 		{Object.keys(opportunities).map(key =>
// 			<a href={`aangemaakte-leerkansen/${key}`}>
// 			<li class="list">
				
// 				<div class="list__opportunity_title">
// 					<div> <img src={opportunities[key].pinImageUrl ? `${opportunities[key].pinImageUrl}` : null}/> </div>
// 					<div class="list__label">
// 						{/* <div class="list__label--header"> Leerkans </div> */}
// 						<div class="list__label--value"><h2> {opportunities[key].title}</h2> </div>
// 					</div>
// 				</div>
// 				<div class="filler"/>
// 				<div class="list__opportunity_data">
// 					<div class="list__label">
// 						<div class="list__label--header"> Begindatum </div>
// 						<div class="list__label--value">{opportunities[key].beginDate}</div>
// 					</div>
// 					<div class="list__label">
// 						<div class="list__label--header"> Einddatum </div>
// 						<div class="list__label--value">{opportunities[key].endDate}</div>
// 					</div>
// 					<div class="list__label">
// 						<div class="list__label--header"> Aantal deelnemers </div>
// 						<div class="list__label--value">{opportunities[key].participations}</div>
// 					</div>
// 					<div class="list__label">
// 						<div class="list__label--header"> Status </div>
// 						{!!(opportunities[key].authority==0) && <div class="list__label--value">In afwachting</div>}
// 						{!(opportunities[key].authority==0) && <div class="list__label--value">Geaccepteerd</div>}
// 					</div>
// 				</div>
// 				<div class="filler"/>
// 				{!!(opportunities[key].authority==0) && <div class="edit tooltip"><a href="#"><i class="fas fa-edit fa-2x"></i></a></div>}
// 				<div class="delete tooltip"><a href="#"><i class="fas fa-trash-alt fa-2x"></i></a></div>
// 				<div class="copy tooltip"><a href={routes.MaakLeerkans+"/"+key}><i class="fas fa-plus fa-2x"></i></a></div>
// 			</li>
// 			</a>
// 			// <a href={`aangemaakte-leerkansen/${key}`} className={`card-item leerkans ${ opportunities[key].category }`} key={opportunities[key].addressId}>
// 			//     <img src={opportunities[key].oppImageUrl ? `${opportunities[key].oppImageUrl}` : null} className="photo" alt="" />
// 			//     <div style={{position: "relative"}}>
// 			//     <img src={`${opportunities[key].pinImageUrl}`} className="badge" alt="" />
// 			//     <h2>{opportunities[key].title}</h2>
// 			//     <div className="meta-data">
// 			//     <small>{opportunities[key].beginDate + ' - ' + opportunities[key].endDate}</small>
// 			//     {/* <small>{opportunities[key].street + ' ' + opportunities[key].house_number + ', ' + opportunities[key].postal_code + ' ' + opportunities[key].city}</small> */}
// 			//     </div>
// 			//     <p>{opportunities[key].shortDescription}</p>
// 			// 	<h2>Status: {(opportunities[key].authority==0) ? `In afwachting` : `Geaccepteerd`}</h2>
// 			//     </div>
// 			// </a>
// 		)}
// 	</ul>
// 	</div>

const EmptyList = () =>
	<div class="container">
		<p>Je hebt nog geen leerkansen aangemaakt.</p>
		<p><a href={routes.MaakLeerkans}>Klik hier </a>om een nieuwe leerkans aan te maken.</p>
	</div>

const LoadingList = () =>
	<div class="container">
		<Spinner />
	</div>

export default List;