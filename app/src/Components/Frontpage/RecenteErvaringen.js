import React, { Component } from 'react';

import ER12345 from './../../assets/ervaringen/ER12345.png';
import ER12346 from './../../assets/ervaringen/ER12346.png';
import ER12347 from './../../assets/ervaringen/ER12347.png';

class RecenteErvaringen extends Component {
	render() {
		return (
			<div id="recente-ervaringen">
				<div className="container">
					<div className="content">
						<h1>Recente Ervaringen</h1>
						<div className="card-container">
							<a href="#" className="card-item ervaring" style={{backgroundImage: `url(${ER12345})`}}>
								<div className="data">
									<h2>Gent is de max!</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
							<a href="#" className="card-item ervaring" style={{backgroundImage: `url(${ER12346})`}}>
								<div className="data">
									<h2>Vindingrijk platform</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
							<a href="#" className="card-item ervaring" style={{backgroundImage: `url(${ER12347})`}}>
								<div className="data">
									<h2>Bedankt Gentlestudent</h2>
									<small>Dries Vanacker - 5 April 2018</small>
								</div>
							</a>
						</div>
						<a className="meer" href="#">Meer ervaringen</a>
					</div>
				</div>
			</div>
		)
	}
}

export default RecenteErvaringen;