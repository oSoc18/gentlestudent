import React, { Component } from 'react';

// import { columns, row } from 'glamor/ous';

import Eyecatcher from './../Components/Issuer/Eyectacher';
import Info from './../Components/Issuer/Info';
import StepsIssuer from './../Components/Issuer/Steps';

import { Breadcrumbs } from './../Components/Utils';

class WordIssuer extends Component {
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