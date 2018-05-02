import React, { Component } from 'react';
import { connect } from 'react-redux';

import Nav from './../Components/Nav.jsx';
import Footer from './../Components/Footer.jsx';
import FormCreateLeerkans from './../Components/Leerkansen/FormCreateLeerkans.jsx';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.showResults = this.showResults.bind(this);
  };
  componentDidMount() {}
  showResults = (values) =>
    new Promise(resolve => {
      setTimeout(() => {
        // simulate server latency
        window.alert(`You submitted:\n\n${JSON.stringify(values, null, 2)}`)
        resolve()
      }, 500)
    })
  render() {
    return (
      <div>
        <Nav/>
            <div className="container">
                <div className="content">
                    <h1>Create Leerkans</h1>
                    <FormCreateLeerkans onSubmit={this.showResults}/>
                </div>
            </div>
        <Footer/>
    </div>
    );
  }
}

export default CreateLeerkans;
