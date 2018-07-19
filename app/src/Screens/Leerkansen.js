import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';

import Maps from './../Components/Leerkansen/Maps';
import SearchFilter from './../Components/Leerkansen/SearchFilters';

import Detail from './../Components/Leerkansen/Detail';
import List from './../Components/Leerkansen/List';

class Leerkansen extends Component {
	componentDidMount() {
	//   this.props.fetchLeerkansen();
	}
	render() {
		return (
			<div>
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

export default Leerkansen;