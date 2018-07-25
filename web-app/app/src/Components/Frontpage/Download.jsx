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
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                            <a href="/">
                                <img src={downloadiOS} alt="download-button-ios" />
                            </a>
                            <a href="/">
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