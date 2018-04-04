import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

class WordIssuer extends Component {
    render() {
        return (
            <div>
                <Nav/>
                    <div className="container">
                        <div className="content">
                            <h1>Word Issuer</h1>
                        </div>
                    </div>
                <Footer/>
            </div>
        )
    }
}

export default WordIssuer;