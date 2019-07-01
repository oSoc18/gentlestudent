import React, { Component } from 'react';

import { Provider } from 'react-redux';
import {
	BrowserRouter as Router,
	Route,
	Switch
} from "react-router-dom";

import store from './store';

import { firebase } from './Utils/Firebase';

import FrontPage from './Components/Anonymous/Frontpage/FrontPage';
import Leerkansen from './Components/SignedIn/Leerkansen/Leerkansen';
import WordIssuer from './Components/Anonymous/WordIssuer';
import Ervaringen from './Components/Anonymous/Ervaringen/Ervaringen';
import Nieuws from './Components/Anonymous/Nieuws/Nieuws';
import OverOns from './Components/Anonymous/OverOns';
import Register from './Components/Anonymous/Auth/Register';
import Login from './Components/Anonymous/Auth/Login';

import BOLeerkansen from './Components/SignedIn/Backoffice/Leerkansen';
import MaakLeerkans from './Components/SignedIn/Issuer/MaakLeerkans';
import IssueBadgeRecipient from './Components/SignedIn/Issuer/IssueBadgeRecipient';
import RegistreerIssuer from './Components/Anonymous/Auth/RegistreerIssuer';
import ValideerIssuer from './Components/SignedIn/Admin/ValideerIssuer';
import ValideerLeerkans from './Components/SignedIn/Admin/ValideerLeerkans';
import AangemaakteLeerkansen from './Components/SignedIn/Issuer/AangemaakteLeerkansen';
import BewerkLeerkans from './Components/SignedIn/Issuer/BewerkLeerkans';
import Profiel from './Components/SignedIn/Backoffice/Profiel';
import Privacy from './Components/Anonymous/Privacy';
import Voorwaarden from './Components/Anonymous/Voorwaarden';
import NoMatch from './Shared/NoMatch';
import Backpack from './Components/SignedIn/Backoffice/Backpack';

import Navigation from './Shared/Navigation';
import Footer from './Shared/Footer';

import withAuthentication from './Shared/withAuthentication';

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