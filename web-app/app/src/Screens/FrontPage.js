import React, { Component } from 'react';

import Leerkansen from './../Components/Frontpage/Leerkansen';
import RecenteErvaringen from './../Components/Frontpage/RecenteErvaringen';
import Download from './../Components/Frontpage/Download';

import eyecather from './../assets/eyecatcher.jpg';
import newImage from './../assets/wat-is-er-nieuw.png';

const newStyle = {
	width: '100vw',
	height: '100%',
	minHeight: '300px',
	backgroundImage: `url(${newImage})`,
	backgroundSize: 'cover',
	backgroundColor: 'black'
};

class FrontPage extends Component {
	componentDidMount() {
		// this.props.check();
		window.scrollTo(0, 0);
	}
	render() {
		return (
			<div>
				<div id="startpage">
					<div className="eyecather-wrapper">
						<img src={eyecather} id="eyecather" alt="eyecather" />
					</div>
					<div className="container">
						<div className="content">
							<h1>Aan de slag met Gentlestudent</h1>
							<h2>“Verken je stad, help je buren.”</h2>
							<form action="">
								<div className="search-wrapper frontpage">
									<i className="fas fa-search"></i>
									<input type="text" placeholder="Probeer “Gent Korenmarkt”"/>
									<button type="submit">Zoeken</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<Leerkansen />
				<div id="new" style={newStyle}>
					<div className="container">
						<div>
							<h2>Zie wat Gentlestudent heeft te bieden en wat je mag verwachten in de toekomst</h2>
							<a href="/">Wat is er nieuw?</a>
						</div>
					</div>
				</div>
				<RecenteErvaringen />
				<Download />
			</div>
		);
	}
}
  
export default FrontPage;