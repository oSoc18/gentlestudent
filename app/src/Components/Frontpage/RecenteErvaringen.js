import React, { Component } from 'react';

class RecenteErvaringen extends Component {
	render() {
		return (
			<div id="recente-ervaringen">
				<div className="container">
					<div className="content">
						<h1>Recente Ervaringen</h1>
						<div className="card-container">
							<a href="#" className="card-item ervaring">
								<h2>Gent is de max!</h2>
								<small>Dries Vanacker - 5 April 2018</small>
							</a>
							<a href="#" className="card-item ervaring">
								<h2>Gent is de max!</h2>
								<small>Dries Vanacker - 5 April 2018</small>
							</a>
							<a href="#" className="card-item ervaring">
								<h2>Bedankt Gentlestudent</h2>
								<small>Dries Vanacker - 5 April 2018</small>
							</a>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default RecenteErvaringen;