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
								Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Cras ultricies ligula sed magna dictum porta.
							</p>
						</div>
						<div className="card-item">
							<h3>Jij bepaalt</h3>
							<p>
								Vivamus suscipit tortor eget felis porttitor volutpat. Cras ultricies ligula sed magna dictum porta. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.
							</p>
						</div>
						<div className="card-item">
							<h3>Waarom zou ik een issuer worden?</h3>
							<p>
								Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Donec rutrum congue leo eget malesuada.
							</p>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default Eyecatcher;