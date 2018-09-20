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
		  initialOpportunities: null,
		  addresses: null
		};
		this.filterOpportunities = this.filterOpportunities.bind(this);
	  }
	componentDidMount() {
		window.scrollTo(0, 0);
		firestore.onceGetValidatedOpportunities().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ opportunities: res }))
			this.setState(() => ({ initialOpportunities: res }))
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
	filterOpportunities(event){
		var initialList = this.state.initialOpportunities;
		var filteredArray = Object.keys(initialList).map(function(key) {
			return [key, initialList[key]];
		  });
		// console.log(filteredArray);
		filteredArray = filteredArray.filter(function(item){
			let content = "";
			Object.keys(item[1]).map(function(key) {
				// console.log(key);
				content += item[1][key];
			});
			// console.log(content);
			return content.toLowerCase().search(event.target.value.toLowerCase()) !== -1;
		});
		// console.log(filteredArray);
		var updatedList = new Object;
		filteredArray.forEach((item, index)=>{
			let key = item[0];
			updatedList[key] = item[1];
		});
		// console.log(updatedList);
		this.setState({opportunities: updatedList});
	  }
	render() {
		const { opportunities, addresses } = this.state;

		return (
			<Switch>
				<Route path={'/leerkansen/:id'} render={({match}) => <Detail opportunities={opportunities}  match={match}/>} />
				<Route path={'/leerkansen'} render={() => 
					<div className="leerkansen-content">
						<div className="content">
							<SearchFilter filterFunction={this.filterOpportunities} />
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

export default Leerkansen;