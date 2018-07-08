import React, { Component } from 'react';
import { connect } from 'react-redux';

import { BadgeFetchList } from './../actions/badgesActions';
import { LeerkansCreateItem } from './../actions/leerkansActions';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';
import FormCreateLeerkans from './../Components/Leerkansen/FormCreateLeerkans';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.submit = this.submit.bind(this);
  };
  componentDidMount() {
		this.props.badgeFetchList();
	}
  submit() {
    this.props.createLeerkans(
      {
        ...this.props.form.createLeerkansForm.values
      }
    );
    console.log(this.props.form.createLeerkansForm.values.image);
    console.log(this.props.form.createLeerkansForm.values);
  }
  showResults = (values) =>
    new Promise(resolve => {
      window.alert(`You submitted:\n\n${JSON.stringify(values, null, 2)}`)
      resolve()
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
      },
      badgeFetchList: () => {
        dispatch(BadgeFetchList());
      }
    };
  }
)(CreateLeerkans));
