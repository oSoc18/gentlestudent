import React, { Component } from 'react';
import Nav from './../Components/Nav';
import Leerkansen from './../Components/Leerkansen';
import Footer from './../Components/Footer';

import eyecather from './../assets/eyecatcher.jpg';

class StartPage extends Component {
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
                                    <input type="text" placeholder="Probeer “Gent Korenmarkt”"/>
                                    <button type="submit">Zoeken</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <Leerkansen />
                <Footer />
            </div>
        );
    }
}
  
export default StartPage;