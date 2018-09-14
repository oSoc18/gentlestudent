import React, { Component } from 'react';
import { auth, firestore } from './../Firebase';

import * as routes from '../../routes/routes.js';

import LK12345 from './../../assets/leerkansen/LK12345.png';
import LK12346 from './../../assets/leerkansen/LK12346.png';
import LK12347 from './../../assets/leerkansen/LK12347.png';
import dg2 from './../../assets/dg2.svg';
import dzh3 from './../../assets/dzh3.svg';
import ons1 from './../../assets/ons1.svg';

class Leerkansen extends Component {
	constructor(props){
		super(props);

		this.state={
			opportunities: null
		};
	}
	componentDidMount(){
		firestore.onceGetLatestOpportunities().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ opportunities: res }))
			console.log(this.state.opportunities);
		  })
		  .catch(err => {
			console.log('Could not fetch opportunity data: ', err);
		  });
	}
	renderLeerkans (id, img, badge, type, title, synopsis, startDate, endDate) {
		return(
			<a href={`${ routes.Leerkansen }/${ id }`} className={`card-item leerkans ${ type }`}>
				<img src={img} className="photo" alt="photoo" />
				<div style={{position: "relative"}}>
					<img src={badge} className="badge" alt="badge" />
					<h2>{title}</h2>
					<div className="meta-data">
						<small>{startDate + ' - ' + endDate}</small>
						{/* <small>{address}</small> */}
					</div>
					<p>{synopsis}</p>
				</div>
			</a>
		)
	}
	render() {
		const { opportunities } = this.state;
		return (
			<div id="leerkansen">
				<div className="container">
					<div className="content">
						<h1 className="uitgelicht">Leerkansen</h1>
							{!!opportunities && 
								<div className="card-container">
									{Object.keys(opportunities).map(key =>
										<a href={`${ routes.Leerkansen }/${ key }`} className={`card-item leerkans ${ opportunities[key].category }`}>
											<div className="crop-opp-img">
												<img src={opportunities[key].oppImageUrl} className="photo " alt="photoo" />
											</div>
											<div style={{position: "relative"}}>
												<img src={opportunities[key].pinImageUrl} className="badge" alt="badge" />
												<h2>{opportunities[key].title}</h2>
												<div className="meta-data">
													<small>{opportunities[key].startDate + ' - ' + opportunities[key].endDate}</small>
													{/* <small>{address}</small> */}
												</div>
												<p>{opportunities[key].shortDescription}</p>
											</div>
										</a>
									)}
								</div>
							}
						<a className="meer" href="/leerkansen">Meer leerkansen</a>
					</div>
				</div>
			</div>
		)
	}
}


export default Leerkansen;