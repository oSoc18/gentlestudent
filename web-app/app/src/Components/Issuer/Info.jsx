import React, { Component } from 'react';

import { cards } from './Styles';

class Eyecatcher extends Component {
	render() {
		return (
			<div className="container">
				<div className="content">
					<div {...cards} className="card-container">
						<div className="card-item">
							<h3>Wat is een issuer</h3>
							<p>
								Een Issuer formuleert een leerkans voor de student. Het kan gaan over het volgen van een eenmalige activiteit tot een langdurig engagement binnen de organisatie. Als issuer maak je de student(en) warm voor een maatschappelijk relevante leerkans.
							</p>
						</div>
						<div className="card-item">
							<h3>Jij bepaalt</h3>
							<p>
								Wat kan de student doen voor jou of jouw organisatie waarmee hij kan bijleren op vlak van duurzaamheid, ondernemingszin, digitale geletterdheid, onderzoek of wereldburgerschap.
							</p>
						</div>
						<div className="card-item">
							<h3>Waarom zou ik een issuer worden?</h3>
							<p>
								Als issuer breng je de studenten dichter bij de buurt, je leert ze kennismaken met een authentieke context en laat hen een bijdrage leveren aan de organisatie. Je bent de brugfiguur tussen studenten en hun buurt/ jouw organisatie.
							</p>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default Eyecatcher;