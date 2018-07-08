import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';

import { LeerkansenFetch } from './../actions/leerkansActions';

import Nav from './../Components/Nav';
import Maps from './../Components/Leerkansen/Maps';
import SearchFilter from './../Components/Leerkansen/SearchFilters';

import Detail from './../Components/Leerkansen/Detail';
import List from './../Components/Leerkansen/List';

class Leerkansen extends Component {
	componentDidMount() {
	  this.props.fetchLeerkansen();
	}
	render() {
		return (
			<div>
				<Nav/>
				<div className="content">
					<SearchFilter />
					<div id="leerkansen">
						<div className="content-left">
							<Switch>
								<Route path={'/leerkansen/:_id'} component={Detail} />
								<Route path={'/leerkansen'} component={List} />
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

export default connect(
	(state) => {
		return {
			leerkansen: state.leerkansen
		};
	},
	(dispatch) => {
		return {
			fetchLeerkansen: () => {
				dispatch(LeerkansenFetch());
			}
		}
	}
)(Leerkansen);