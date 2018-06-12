import React, { Component } from 'react';
import { connect } from 'react-redux';

class Detail extends Component {
  render() {
    return (
      <div>
        <h1>{this.props.match.params._id}</h1>
      </div>
    )
  }
}

export default connect(
  (state) => {
    return {};
  },
  (dispatch) => {
    return {};
  }
)(Detail);
