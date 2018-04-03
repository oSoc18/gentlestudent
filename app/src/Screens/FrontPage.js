import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Leerkansen from './../Components/Frontpage/Leerkansen';
import Steps from './../Components/Frontpage/Steps';
import Footer from './../Components/Footer';

import eyecather from './../assets/eyecatcher.jpg';

class FrontPage extends Component {
    render() {
        return (
            <div>
                <Nav />
                <div id="startpage">
                    <div className="eyecather-wrapper">
                        <img src={eyecather} id="eyecather" alt="eyecather" />
                    </div>
                    <div className="container">
                        <div className="content">
                            <h1>Aan de slag met Gentlestudent</h1>
                            <h2>“Slagzin die aanzet tot actie en Gentlestudent voorstelt.”</h2>
                            <form action="">
                                <div className="search-wrapper">
                                    <i className="fas fa-search"></i>
                                    <input type="text" placeholder="Probeer “Gent Korenmarkt”"/>
                                    <button type="submit">Zoeken</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <Leerkansen />
                <Steps />
                <Footer />
            </div>
        );
    }
}
  
export default FrontPage;