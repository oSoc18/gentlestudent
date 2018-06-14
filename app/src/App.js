import React, { Component } from 'react';

import { Provider } from 'react-redux';
import {
	BrowserRouter as Router,
	Route,
	Switch
} from "react-router-dom";

import store from './store';

import FrontPage from './Screens/FrontPage';
import Leerkansen from './Screens/Leerkansen';
import CreateLeerkansen from './Screens/CreateLeerkans';
import WordIssuer from './Screens/WordIssuer';
import Ervaringen from './Screens/Ervaringen';
import Nieuws from './Screens/Nieuws';
import OverOns from './Screens/OverOns';
import IssueBadgeRecipient from './Screens/Issuers/IssueBadgeRecipient';

class App extends Component {
	render() {
		return (
			<Provider store={store}>
				<Router>
					<Switch>
						<Route path="/" exact render={() => <FrontPage />} />
						<Route path="/leerkansen" render={() => <Leerkansen />} />
						<Route path="/create-leerkansen" exact render={() => <CreateLeerkansen />} />
						<Route path="/word-issuer" exact render={() => <WordIssuer />} />
						<Route path="/ervaringen" exact render={() => <Ervaringen />} />
						<Route path="/nieuws" exact render={() => <Nieuws />} />
						<Route path="/overons" exact render={() => <OverOns />} />
						{/* ISSUERS */}
						{/* <Auth> */}
							<Route path="/issue-badge-recipient" exact render={() => <IssueBadgeRecipient />} />
						{/* </Auth> */}
					</Switch>
				</Router>
			</Provider>
		);
	}
}

export default App;