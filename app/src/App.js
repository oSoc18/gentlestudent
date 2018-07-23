import React, { Component } from 'react';

import { Provider } from 'react-redux';
import {
	BrowserRouter as Router,
	Route,
	Switch
} from "react-router-dom";

import store from './store';

import { firebase } from './Components/Firebase';

import FrontPage from './Screens/FrontPage';
import Leerkansen from './Screens/Leerkansen';
import WordIssuer from './Screens/WordIssuer';
import Ervaringen from './Screens/Ervaringen';
import Nieuws from './Screens/Nieuws';
import OverOns from './Screens/OverOns';
import Register from './Components/Auth/Register';
import Login from './Components/Auth/Login';

import MaakLeerkans from './Screens/Backoffice/MaakLeerkans';
import BOLeerkansen from './Screens/Backoffice/Leerkansen';
import IssueBadgeRecipient from './Screens/Issuers/IssueBadgeRecipient';
import RegistreerIssuer from './Screens/RegistreerIssuer';
import ValidateIssuer from './Screens/Backoffice/ValidateIssuer';

import Navigation from './Components/Navigation';
import Footer from './Components/Footer';

import withAuthentication from './Components/withAuthentication';

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
								<Route path={routes.MaakLeerkans} exact render={() => <MaakLeerkans />} />
								<Route path={routes.IssueBadgeRecipient} exact render={() => <IssueBadgeRecipient />} />
								<Route path={routes.RegistreerIssuer} exact render={() => <RegistreerIssuer />} />
								<Route path={routes.ValidateIssuer} exact render={() => <ValidateIssuer />} />
							{/* </Auth> */}
						</Switch>
						<Footer/>
					</div>
				</Router>
			</Provider>
		);
	}
}


export default withAuthentication(App);