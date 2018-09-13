import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';

import { firestore } from './../../Components/Firebase';
import { auth } from './../../Components/Firebase/firebase';

import Maps from './../../Components/Leerkansen/Maps';
import SearchFilter from './../../Components/Leerkansen/SearchFilters';

import AangemaakteLeerkansDetail from './../../Components/Issuer/AangemaakteLeerkansDetail';
import List from './../../Components/Issuer/AangemaakteLeerkansen';
// import Detail from './../../Components/Leerkansen/Detail';

class AangemaakteLeerkansen extends Component {
	constructor(props) {
		super(props);
	
		this.state = {
		  opportunities: null,
		  userId: "",
		  isAdmin: false
		};

		this.getOpportunities = this.getOpportunities.bind(this);
	  }
	componentDidMount() {
        auth.onAuthStateChanged((user) => {
            if (user) {
				this.state.userId = user.uid;
				firestore.onceGetAdmin(this.state.userId).then(doc => {
					var res = new Object();
					if(doc.data()){
						this.setState(() => ({ isAdmin: true }));
					}
					this.getOpportunities();
				})
				.catch(err => {
					console.log('User is not an admin', err);
					this.getOpportunities();
				});
                // console.log(id);
            }
        });
	}
	getOpportunities(){
		let id = this.state.userId;
		if(this.state.isAdmin){
			console.log("user is admin, fetching all opportunities");
			firestore.onceGetOpportunities().then(snapshot => {
				var res = new Object();
				snapshot.forEach(doc => {
					if(doc.data().authority!=2){
						res[doc.id] = doc.data();
					}
				});
				this.setState(() => ({ opportunities: res }));
				// console.log(JSON.stringify(this.state.opportunities));
			})
			.catch(err => {
				console.log('Error getting documents', err);
			});
		}
		else{
			console.log("user is not an admin, fetching only the opportunities made by the user")
			firestore.onceGetCreatedOpportunities(id).then(snapshot => {
				var res = new Object();
				snapshot.forEach(doc => {
					if(doc.data().authority!=2){
						res[doc.id] = doc.data();
					}
				});
				this.setState(() => ({ opportunities: res }));
				// console.log(JSON.stringify(this.state.opportunities));
			})
			.catch(err => {
				console.log('Error getting documents', err);
			});
		}
	}
	render() {
		const { opportunities } = this.state;

		return (
			<div className="leerkansen-content">
				<div className="content">
					{/* <SearchFilter /> */}
					<div className="fixed opp-list-page">
            			<h1>Aangemaakte leerkansen</h1>
						<p> Deze leerkansen werden door jou aangemaakt:</p>
					</div>
					<div id="aangemaakte-leerkansen">
						<Switch>
							{/* <Route path={'/aangemaakte-leerkansen/:id'} render={({match}) => <Detail opportunities={opportunities}  match={match}/>} /> */}
							<Route path={'/aangemaakte-leerkansen/:id'} render={({match}) => <AangemaakteLeerkansDetail opportunities={opportunities}  match={match}/>} />
							<Route path={'/aangemaakte-leerkansen'} render={() => <List opportunities={opportunities} getOpportunities={this.getOpportunities}/>} />
						</Switch>
					</div>
				</div>
			</div>
		)
	}
}

export default AangemaakteLeerkansen;