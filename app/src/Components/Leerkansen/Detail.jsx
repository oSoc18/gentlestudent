import React, { Component } from 'react';
import { connect } from 'react-redux';

class Detail extends Component {
  render() {
    const { opportunities } = this.props;
    let id = this.props.match.params.id;

    return (
      <div>
        <a href="/leerkansen">Back</a>
        {/* <h1>{opportunities[id].title}</h1>
        <p>{opportunities[id].description}</p> */}
      </div>
    )
  }
}

export default Detail;
