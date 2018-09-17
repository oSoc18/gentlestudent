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
	// this.props.check();
	setInterval(() => {
		this.setState({redirect: true});
	}, 5000);
  }
	render() {
		const { redirect } = this.state;
		return (
			<div>
				<div id="startpage">
					<div className="eyecather-wrapper">
						<img src={eyecather} id="eyecather" alt="eyecather" />
					</div>
					<div className="container">
						<div className="content">
							<h1>Oeps, er is iets misgelopen</h1>
							<p>Je wordt teruggestuurd naar de <a href="/">voorpagina</a> in enkele seconden..</p>
						</div>
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