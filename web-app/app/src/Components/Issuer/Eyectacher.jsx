import React, { Component } from 'react';

import { eyecatcherWrapper, section } from './Styles';

import Image from './../../assets/word-issuer.jpg';

class Eyecatcher extends Component {
	render() {
		return (
      <React.Fragment>
        <div id="word-issuer" {...section}>
          <div {...eyecatcherWrapper}>
            <img src={Image} alt="eyecatcher-word-issuer" className="eyecatcher-word-issuer" />
          </div>
          <div className="container">
            <div className="content">
              <h1>Word vandaag nog een issuer!</h1>
            </div>
          </div>
        </div>
      </React.Fragment>
		)
	}
}

export default Eyecatcher;