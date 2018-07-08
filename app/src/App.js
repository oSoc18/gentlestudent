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
import WordIssuer from './Screens/WordIssuer';
import Ervaringen from './Screens/Ervaringen';
import Nieuws from './Screens/Nieuws';
import OverOns from './Screens/OverOns';
import Register from './Screens/Register';

import CreateLeerkansen from './Screens/Backoffice/CreateLeerkans';
import BOLeerkansen from './Screens/Backoffice/Leerkansen';
import IssueBadgeRecipient from './Screens/Issuers/IssueBadgeRecipient';

class App extends Component {
	render() {
		return (
			<Provider store={store}>
				<Router>
					<Switch>
						<Route path="/" exact render={() => <FrontPage />} />
						<Route path="/leerkansen" render={() => <Leerkansen />} />
						<Route path="/word-issuer" exact render={() => <WordIssuer />} />
						<Route path="/ervaringen" exact render={() => <Ervaringen />} />
						<Route path="/nieuws" exact render={() => <Nieuws />} />
						<Route path="/overons" exact render={() => <OverOns />} />
						<Route path="/register" render={() => <Register />} />
						{/* <Route path="/login" render={() => <Login />} /> */}
						{/* BACKOFFICE */}
						{/* <Auth> */}
							<Route path="/backoffice/leerkansen" exact render={() => <BOLeerkansen />} />
							<Route path="/backoffice/create-leerkansen" exact render={() => <CreateLeerkansen />} />
							<Route path="/backoffice/issue-badge-recipient" exact render={() => <IssueBadgeRecipient />} />
						{/* </Auth> */}
					</Switch>
				</Router>
			</Provider>
		);
	}
}

export default App;