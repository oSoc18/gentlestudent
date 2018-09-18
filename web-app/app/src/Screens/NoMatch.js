import React, { Component } from 'react';
import { withRouter } from 'react-router-dom'

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

class NoMatch extends Component {
	constructor(props){
		super(props);

		this.state = {
			redirect: false
		}
	}
	componentDidMount() {
		window.scrollTo(0, 0);
		// this.props.check();
		setInterval(() => {
			this.setState({redirect: true});
		}, 10000);
  }
	render() {
		const { redirect } = this.state;
		return (
			<div id="fourOhFour">
				{/* <div className="eyecather-wrapper">
					<img src={eyecather} id="eyecather" alt="eyecather" />
				</div> */}
				<div className="container">
					<div className="content content-with-padding">
						<h1>404</h1>
						<h2>Oeps, er is iets misgelopen =(</h2>
						<p>Geen paniek, we hebben het onder controle.
						Je zal worden teruggebracht naar de <a href="/">voorpagina</a> in enkele seconden..</p>
						{/* <p>Heb je een verkeerde url gebruikt of iets proberen doen wat niet mag? </p>
						<p>Indien niet verontschuldigen onze developers zich. Ze weten niet beter. </p> */}
					</div>
				</div>
				{!!redirect && <DelayedRedirect />}
			</div>
		);
	}
}

const DelayedRedirect = withRouter(({ history }) => (
	<React.Fragment>
		{ history.push('/') }
	</React.Fragment>
  ))
  
export default NoMatch;