import React, { Component } from 'react';
import { connect } from 'react-redux';

class Detail extends Component {
  componentDidMount() {
    this.props.fetchLeerkansenById(this.props.match.params._id);
  }
  render() {
    return (
      <div>
        <a href="/leerkansen">Back</a>
        <h1>{this.props.leerkansen.item.title}</h1>
        <p>{this.props.leerkansen.item.description}</p>
      </div>
    )
  }
}

export default Detail;
