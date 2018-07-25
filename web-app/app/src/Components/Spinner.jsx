import React from 'react';

import { css } from 'glamor';

import { ScaleLoader } from 'react-spinners';
import { $primary } from './../variables';

const loader = css({
  textAlign: 'center',
  lineHeight: 'calc(100vh - 204px)'
})

class Spinner extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: true
    }
  }
  render() {
    return (
      <div {...loader}>
        <ScaleLoader
          color={$primary} 
          loading={this.state.loading}
        />
      </div>
    )
  }
}

export default Spinner;