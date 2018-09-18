import React, { Component } from 'react';
import { auth, firestore } from './../Firebase';

import * as routes from '../../routes/routes.js';

import ER12345 from './../../assets/ervaringen/ER12345.png';
import ER12346 from './../../assets/ervaringen/ER12346.png';
import ER12347 from './../../assets/ervaringen/ER12347.png';

class RecenteErvaringen extends Component {
	constructor(props){
		super(props);

		this.state={
			experiences: null
		};
	}
	componentDidMount(){
		firestore.onceGetLatestExperiences().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ experiences: res }))
			console.log(this.state.experiences);
		  })
		  .catch(err => {
			console.log('Could not fetch opportunity data: ', err);
		  });
	}
	render() {
		const { experiences } = this.state;
		return (
			<div id="recente-ervaringen">
				<div className="container">
					<div className="content">
						<h1>Recente Ervaringen</h1>
						{!!experiences && 
							<div className="card-container">
								{Object.keys(experiences).map(key =>
									<a href={`${ routes.Ervaringen }/${ key }`} className="card-item ervaring ervaring-gradient" style={{backgroundImage: `url(${experiences[key].imageUrl})`, backgroundPosition: 'center center'}}>
										<div className="data">
											<h2>{experiences[key].title}</h2>
											<small>{experiences[key].author} - {experiences[key].published}</small>
										</div>
									</a>
								)}
							</div>
						}
						{/* <div className="card-container">
							<a href="/" className="card-item ervaring" style={{backgroundImage: `url(${ER12345})`}}>
								<div className="data">
									<h2>Gent is de max!</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
							<a href="/" className="card-item ervaring" style={{backgroundImage: `url(${ER12346})`}}>
								<div className="data">
									<h2>Vindingrijk platform</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
							<a href="/" className="card-item ervaring" style={{backgroundImage: `url(${ER12347})`}}>
								<div className="data">
									<h2>Bedankt Gentlestudent</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
						</div> */}
						<a className="meer" href="/ervaringen">Meer ervaringen</a>
					</div>
				</div>
			</div>
		)
	}
}

export default RecenteErvaringen;