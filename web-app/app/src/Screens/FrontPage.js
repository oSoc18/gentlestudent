import React, { Component } from 'react';

import Leerkansen from './../Components/Frontpage/Leerkansen';
import RecenteErvaringen from './../Components/Frontpage/RecenteErvaringen';
import Download from './../Components/Frontpage/Download';

import eyecather from './../assets/eyecatcher.jpg';
import newImage from './../assets/wat-is-er-nieuw.png';

const newStyle = {
	width: '100%',
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
		// window.addEventListener('load', () => {
			// console.log("loaded");
			setTimeout( () => {
				var img = document.getElementById("startpage").getElementsByTagName('img')[0]; 
				// console.log(img);
				img.style['filter'] = 'blur(0px)';
				img.style['-webkit-filter'] = 'blur(0px)';
			}, 1000 );
		// });
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
							{/* <form action="">
								<div className="search-wrapper frontpage">
									<i className="fas fa-search"></i>
									<input type="text" placeholder="Probeer “Gent Korenmarkt”"/>
									<button type="submit">Zoeken</button>
								</div>
							</form> */}
							<div className="text">
								<p>In de stad valt veel te leren, ontdek als <b>student</b> waar je je allemaal kunt verrijken. Vul je leven en geest en laat anderen meegenieten van je Gentle-talent.</p>
								<p>Laat van je missie horen en betrek als <b>organisatie of buurt</b> studenten bij jullie projecten en geef ze de kans om ervaringen op te doen in een authentieke setting.</p>
							</div>
							<div className="introductory-video">
								<iframe src="https://arteveldehogeschool.cloud.panopto.eu/Panopto/Pages/Embed.aspx?id=dc47c1a8-68b9-413b-812a-aa1400a18754&v=1" 
									width="720"
									height="405"
									frameborder="0"
									allowfullscreen allow="autoplay">
								</iframe>
							</div>
						</div>
						<a className="scroll-down-arrow"href="#anchor"><span></span></a>
					</div>
				</div>
				<div id="anchor"></div>
				<Leerkansen />
				<div id="new" style={newStyle}>
					<div className="container">
						<div>
							<h2>Zie wat Gentlestudent heeft te bieden en wat je mag verwachten in de toekomst</h2>
							<a href="/nieuws">Wat is er nieuw?</a>
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