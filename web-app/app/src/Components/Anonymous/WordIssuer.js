import React, { Component } from 'react';

// import { columns, row } from 'glamor/ous';

import Eyecatcher from '../SignedIn/Issuer/Eyecatcher';
import Info from '../SignedIn/Issuer/Info';
import StepsIssuer from '../SignedIn/Issuer/Steps';

import { Breadcrumbs } from '../../Shared/Utils';

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