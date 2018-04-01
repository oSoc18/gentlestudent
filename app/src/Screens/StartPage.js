import React, { Component } from 'react';
import Nav from '../Components/Nav';
import Footer from '../Components/Footer';

class StartPage extends Component {
    render() {
        return (
            <div>
                <Nav />

                <div className="container full-height">
                    <div className="content">
                        Content
                    </div>
                </div>

                <Footer />
            </div>
        );
    }
}
  
export default StartPage;