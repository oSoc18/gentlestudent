import React, { Component } from 'react';
import { connect } from 'react-redux';

import { LeerkansCreateItem } from './../actions/leerkansActions';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';
import FormCreateLeerkans from './../Components/Leerkansen/FormCreateLeerkans';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.submit = this.submit.bind(this);
  };
  submit() {
    this.props.createLeerkans(
      {
        ...this.props.form.createLeerkansForm.values,
        image: this.props.form.createLeerkansForm.values.files[0]
      }
    )
    console.log(this.props.form.createLeerkansForm.values.files[0]);
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
