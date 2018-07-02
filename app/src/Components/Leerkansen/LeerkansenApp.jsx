import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from "react-router-dom";

import Detail from './Detail';
import List from './List';

class LeerkansenApp extends Component {
	render() {
		return (
			<React.Fragment>
				<Switch>
					<Route path={'/leerkansen/:_id'} component={Detail} />
					<Route path={'/leerkansen'} component={List} />
				</Switch>
			</React.Fragment>
		)
	}
}

export default connect(
  (state) => {
    return {};
  },
  (dispatch) => {
    return {};
  }
)(LeerkansenApp);