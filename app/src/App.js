import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link, Switch } from "react-router-dom";

// import Routes from './routes/router';
import FrontPage from './Screens/FrontPage';
import Leerkansen from './Screens/Leerkansen';
import WordIssuer from './Screens/WordIssuer';
import Ervaringen from './Screens/Ervaringen';
import Nieuws from './Screens/Nieuws';
import OverOns from './Screens/OverOns';


class App extends Component {
	render() {
		return (
			<Router>
				<Switch>
					<Route path="/" exact render={() => <FrontPage/>} />
					<Route path="/leerkansen" exact render={() => <Leerkansen/>} />
					<Route path="/wordissuer" exact render={() => <WordIssuer/>} />
					<Route path="/ervaringen" exact render={() => <Ervaringen/>} />
					<Route path="/nieuws" exact render={() => <Nieuws/>} />
					<Route path="/overons" exact render={() => <OverOns/>} />
				</Switch>
			</Router>
		);
	}
}

export default App;