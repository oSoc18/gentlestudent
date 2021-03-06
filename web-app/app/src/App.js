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

import BOLeerkansen from './Screens/Backoffice/Leerkansen';
import MaakLeerkans from './Screens/Issuer/MaakLeerkans';
import IssueBadgeRecipient from './Screens/Issuer/IssueBadgeRecipient';
import RegistreerIssuer from './Screens/RegistreerIssuer';
import ValideerIssuer from './Screens/Admin/ValideerIssuer';
import ValideerLeerkans from './Screens/Admin/ValideerLeerkans';
import AangemaakteLeerkansen from './Screens/Issuer/AangemaakteLeerkansen';
import BewerkLeerkans from './Components/Issuer/BewerkLeerkans';
import Profiel from './Screens/Backoffice/Profiel';
import Privacy from './Screens/Privacy';
import Voorwaarden from './Screens/Voorwaarden';
import NoMatch from './Screens/NoMatch';
import Backpack from './Screens/Backoffice/Backpack';

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
						<div class="main-content">
						<Switch>
								<Route path={routes.FrontPage} exact render={() => <FrontPage />} />
								<Route path={routes.Leerkansen} render={() => <Leerkansen />} />
								<Route path={routes.WordIssuer} exact render={() => <WordIssuer />} />
								<Route path={routes.Ervaringen} render={() => <Ervaringen />} />
								<Route path={routes.Nieuws} render={() => <Nieuws />} />
								<Route path={routes.OverOns} exact render={() => <OverOns />} />
								<Route path={routes.Register} render={() => <Register />} />
								<Route path={routes.Login} render={() => <Login />} />
								{/* <Route path="/login" render={() => <Login />} /> */}
								{/* BACKOFFICE */}
								{/* <Auth> */}
								<Route path={routes.BOLeerkansen} exact render={() => <BOLeerkansen />} />
								<Route path={routes.MaakLeerkans} exact render={() => <MaakLeerkans />} />
								<Route path={routes.MaakLeerkans+'/:id'} exact render={({match}) => <MaakLeerkans match={match}/>} />
								<Route path={routes.IssueBadgeRecipient} exact render={() => <IssueBadgeRecipient />} />
								<Route path={routes.RegistreerIssuer} exact render={() => <RegistreerIssuer />} />
								<Route path={routes.ValideerIssuer} exact render={() => <ValideerIssuer />} />
								<Route path={routes.ValideerLeerkans} exact render={() => <ValideerLeerkans />} />
								<Route path={routes.AangemaakteLeerkansen} render={() => <AangemaakteLeerkansen />} />
								<Route path={routes.BewerkLeerkans+'/:id'} render={() => <BewerkLeerkans />} />
								<Route path={routes.Profiel} exact render={() => <Profiel />} />
								<Route path={routes.Backpack} exact render={() => <Backpack />} />
								<Route path={routes.Privacy} exact render={() => <Privacy />} />
								<Route path={routes.Voorwaarden} exact render={() => <Voorwaarden />} />
								<Route path="*" render={() => <NoMatch />} />
								{/* </Auth> */}
						</Switch>
						</div>
						<Footer/>
					</div>
				</Router>
			</Provider>
		);
	}
}


export default withAuthentication(App);