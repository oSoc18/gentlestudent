import React from "react";
import { BrowserRouter as Router, Route, Link, Switch } from "react-router-dom";

import FrontPage from '../Screens/FrontPage';
import Leerkansen from '../Screens/Leerkansen';

export default () => {(
    <Router>
        <Switch>
            <Route path="/" exact render={() => <FrontPage/>} />
            <Route path="/about" exact render={() => <h1>About</h1>} />
        </Switch>
    </Router>
)}