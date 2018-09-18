import React, { Component } from 'react';

import mockup from './../../assets/download-mobile-app.png';
import downloadAndroid from './../../assets/android.png';
import downloadiOS from './../../assets/ios.png';

class Download extends Component {
    render() {
        return (
            <div id="download">
                <div className="container">
                    <div className="content">
                        <div className="left">
                            <img src={mockup} alt="mockup" />
                        </div>
                        <div className="right">
                            <h1>Download de mobile app</h1>
                            <p>Om als student zicht te krijgen op waar de leerkansen zich in Gent situeren, kan je de Gentlestudent app downloaden. Deze app zal je melden wanneer je in de buurt bent van een leerkans. Via de app kan je ook het overzicht bewaren van de leerkansen waar je je voor hebt ingeschreven.</p>
                            <a href="https://itunes.apple.com/us/app/gentlestudent/id1417851918?mt=8&ign-mpt=uo%3D4">
                                <img src={downloadiOS} alt="download-button-ios" />
                            </a>
                            <a href="http://play.google.com/store/apps/details?id=gent.gentlestudent">
                                <img src={downloadAndroid} alt="download-button-android" />
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

export default Download;