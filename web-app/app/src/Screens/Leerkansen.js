import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';

import { firestore } from './../Components/Firebase';

import Maps from './../Components/Leerkansen/Maps';
import SearchFilter from './../Components/Leerkansen/SearchFilters';

import Detail from './../Components/Leerkansen/Detail';
import List from './../Components/Leerkansen/List';

class Leerkansen extends Component {
	constructor(props) {
		super(props);
	
		this.state = {
		  opportunities: null,
		  addresses: null
		};
	  }
	componentDidMount() {
		firestore.onceGetValidatedOpportunities().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ opportunities: res }))
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
		firestore.onceGetAddresses().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ addresses: res }))
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
	}
	render() {
		const { opportunities } = this.state;
		const { addresses } = this.state;

		return (
			<Switch>
				<Route path={'/leerkansen/:id'} render={({match}) => <Detail opportunities={opportunities}  match={match}/>} />
				<Route path={'/leerkansen'} render={() => 
					<div className="leerkansen-content">
						<div className="content">
							<SearchFilter />
							<div id="leerkansen">
								<div className="content-left">
									<List opportunities={opportunities} />
								</div>
								<div className="content-right">
									<div className="content map-container" id="stickybox">
										{!!opportunities && !!addresses && <Maps opportunities={opportunities} addresses={addresses}/>}
									</div>
								</div>
							</div>
						</div>
					</div>
				} />
			</Switch>
		)
	}
}

//the following code makes the div holding the google maps widget follow the scroll until the footer
window.onload = function() {
	//throttles a listener (like onscroll) to limit the amount of times the callback function gets called per second
	function throttler(ms, callback) {
		var timer;
	
		return function() {
			var self = this, args = arguments;
			clearTimeout(timer);
			timer = setTimeout(function() {
				callback.apply(self, args);
			}, ms);
		};
	}

	function getScrollTop() {
	  if (typeof window.pageYOffset !== 'undefined' ) {
		// Most browsers
		return window.pageYOffset;
	  }
  
	  var d = document.documentElement;
	  if (d.clientHeight) {
		// IE in standards mode
		return d.scrollTop;
	  }
  
	  // IE in quirks mode
	  return document.body.scrollTop;
	}
  
	window.onscroll = throttler(10, function() {
	  var box = document.getElementById('stickybox'),
		  scroll = getScrollTop();
		// console.log(scroll);
	  if (scroll <= 200) {
		box.style.top = "0px";
	  }
	  else {
		  if(scroll<=box.parentElement.clientHeight-400){
			box.style.top = (scroll - 200) + "px";
		  }
	  }
	});
  
  };

export default Leerkansen;