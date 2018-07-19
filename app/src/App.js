import React, { Component } from 'react';

import { Provider } from 'react-redux';
import {
	BrowserRouter as Router,
	Route,
	Switch
} from "react-router-dom";

import store from './store';

import { firebase } from './Components/firebase';

import FrontPage from './Screens/FrontPage';
import Leerkansen from './Screens/Leerkansen';
import WordIssuer from './Screens/WordIssuer';
import Ervaringen from './Screens/Ervaringen';
import Nieuws from './Screens/Nieuws';
import OverOns from './Screens/OverOns';
import Register from './Components/Auth/Register';
import Login from './Components/Auth/Login';

import CreateLeerkansen from './Screens/Backoffice/CreateLeerkans';
import BOLeerkansen from './Screens/Backoffice/Leerkansen';
import IssueBadgeRecipient from './Screens/Issuers/IssueBadgeRecipient';

import Navigation from './Components/Navigation';
import Footer from './Components/Footer';

import WithAuthentication from './Components/WithAuthentication';

import * as routes from './routes/routes';

class App extends Component {
	render() {
		return (
			<Provider store={store}>
				<Router>
					<div>
						<Navigation/>
						<Switch>
							<Route path={routes.FrontPage} exact render={() => <FrontPage />} />
							<Route path={routes.Leerkansen} render={() => <Leerkansen />} />
							<Route path={routes.WordIssuer} exact render={() => <WordIssuer />} />
							<Route path={routes.Ervaringen} exact render={() => <Ervaringen />} />
							<Route path={routes.Nieuws} exact render={() => <Nieuws />} />
							<Route path={routes.OverOns} exact render={() => <OverOns />} />
							<Route path={routes.Register} render={() => <Register />} />
							<Route path={routes.Login} render={() => <Login />} />
							{/* <Route path="/login" render={() => <Login />} /> */}
							{/* BACKOFFICE */}
							{/* <Auth> */}
								<Route path={routes.BOLeerkansen} exact render={() => <BOLeerkansen />} />
								<Route path={routes.CreateLeerkansen} exact render={() => <CreateLeerkansen />} />
								<Route path={routes.IssueBadgeRecipient} exact render={() => <IssueBadgeRecipient />} />
							{/* </Auth> */}
						</Switch>
						<Footer/>
					</div>
				</Router>
			</Provider>
		);
	}
}


export default WithAuthentication(App);