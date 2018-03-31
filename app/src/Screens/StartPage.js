import React, { Component } from 'react';
import Nav from '../Components/Nav';
import Footer from '../Components/Footer';

import logo from '../logo.svg';

class StartPage extends Component {
    render() {
        return (
            <div className="App">

                <Nav />

                <header className="App-header">
                    <img src={logo} className="App-logo" alt="logo" />
                    <h1 className="App-title">Welcome to React</h1>
                </header>
        
                <p className="App-intro">
                    To get started, edit <code>src/App.js</code> and save to reload.
                </p>

                <Footer />
            
            </div>
        );
    }
}
  
export default StartPage;