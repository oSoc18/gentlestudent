import React, { Component } from 'react';
import { connect } from 'react-redux';

import { LeerkansCreateItem } from './../actions/leerkansActions';

import Nav from './../Components/Nav.jsx';
import Footer from './../Components/Footer.jsx';
import FormCreateLeerkans from './../Components/Leerkansen/FormCreateLeerkans.jsx';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.submit = this.submit.bind(this);
  };
  componentDidMount() {}
  submit() {
    this.props.createLeerkans(
      {...this.props.form.createLeerkansForm.values}
    )
  }
  showResults = (values) =>
    new Promise(resolve => {
      setTimeout(() => {
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
                    <div className="form" id="create_leerkans">
                      <FormCreateLeerkans onSubmit={this.submit}/>
                    </div>
                </div>
            </div>
        <Footer/>
    </div>
    );
  }
}

export default (CreateLeerkans = connect(
  (state) => {
    return {
      form: state.form
    };
  },
  (dispatch) => {
    return {
      createLeerkans: (data) => {
        dispatch(LeerkansCreateItem(data));
      }
    };
  }
)(CreateLeerkans));
