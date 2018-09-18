import React, { Component } from 'react';

// import { columns, row } from 'glamor/ous';

import Eyecatcher from './../Components/Issuer/Eyecatcher';
import Info from './../Components/Issuer/Info';
import StepsIssuer from './../Components/Issuer/Steps';

import { Breadcrumbs } from './../Components/Utils';

class WordIssuer extends Component {
  componentDidMount(){
    window.scrollTo(0, 0);
  }
  render() {
    return (
      <div>
        <Eyecatcher />
        <Breadcrumbs />
        <Info />
        <StepsIssuer />
      </div>
    )
  }
}

export default WordIssuer;