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
		};
	  }
	componentDidMount() {
        auth.onAuthStateChanged((user) => {
            if (user) {
                let id = user.uid;
                // console.log(id);
                firestore.onceGetCreatedOpportunities(id).then(snapshot => {
                    var res = new Object();
                    snapshot.forEach(doc => {
                        res[doc.id] = doc.data();
                    });
                    this.setState(() => ({ opportunities: res }));
                    // console.log(JSON.stringify(this.state.opportunities));
                })
                .catch(err => {
                    console.log('Error getting documents', err);
                });
            }
        });
	}
	render() {
		const { opportunities } = this.state;

		return (
			<div>
				<div className="content">
					{/* <SearchFilter /> */}
					<div className="fixed">
            			<h1>Mijn aangemaakte leerkansen</h1>
					</div>
					<div id="aangemaakte-leerkansen">
						<div className="content-left">
							<Switch>
                                {/* <Route path={'/aangemaakte-leerkansen/:id'} render={({match}) => <Detail opportunities={opportunities}  match={match}/>} /> */}
								<Route path={'/aangemaakte-leerkansen/:id'} render={({match}) => <AangemaakteLeerkansDetail opportunities={opportunities}  match={match}/>} />
								<Route path={'/aangemaakte-leerkansen'} render={() => <List opportunities={opportunities} />} />
							</Switch>
						</div>
						<div className="content-right">
							<div className="content">
								<Maps />
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default AangemaakteLeerkansen;