import React, { Component } from 'react';

// import { columns, row } from 'glamor/ous';

import Nav from './../Components/Nav';
import Eyecatcher from './../Components/Issuer/Eyectacher';
import Info from './../Components/Issuer/Info';
import StepsIssuer from './../Components/Issuer/Steps';
import Footer from './../Components/Footer';

import { Breadcrumbs } from './../Components/Utils';

class WordIssuer extends Component {
  render() {
    return (
      <div>
        <Nav />
        <Eyecatcher />
        <Breadcrumbs />
        <Info />
        <StepsIssuer />
        <Footer />
      </div>
    )
  }
}

export default WordIssuer;