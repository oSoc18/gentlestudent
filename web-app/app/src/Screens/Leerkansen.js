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
			<div className="leerkansen-content">
				<div className="content">
					<SearchFilter />
					<div id="leerkansen">
						<div className="content-left">
							<Switch>
								<Route path={'/leerkansen/:id'} render={({match}) => <Detail opportunities={opportunities}  match={match}/>} />
								<Route path={'/leerkansen'} render={() => <List opportunities={opportunities} />} />
							</Switch>
						</div>
						<div className="content-right">
							<div className="content">
								<Maps opportunities={opportunities} addresses={addresses}/>
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default Leerkansen;