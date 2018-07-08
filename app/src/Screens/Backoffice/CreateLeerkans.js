import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import { BadgeFetchList } from './../../actions/badgesActions';
import { LeerkansCreateItem } from './../../actions/leerkansActions';

import Nav from './../../Components/Nav';
import Footer from './../../Components/Footer';
import FormCreateLeerkans from './../../Components/Leerkansen/FormCreateLeerkans';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.submit = this.submit.bind(this);
  };
  componentDidMount() {
		this.props.badgeFetchList();
	}
  submit() {
    /* 
    * Get the badge from state
    * Findindex in the state and get the name
    * Split the name in 2 and automatically assign level and type to the database without inputs
    */
     const index = this.props.badge.list.findIndex(b => {
      return b.slug === this.props.form.createLeerkansForm.values.badge
    });
    const nameBadge = this.props.badge.list[index].name.split(' #');
    this.props.createLeerkans(
      {
        ...this.props.form.createLeerkansForm.values,
        type: nameBadge[0].replace(' ', '-').toLowerCase(),
        level: nameBadge[1]
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
              <Link to="/backoffice/leerkansen">Back</Link>
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
      form: state.form,
      badge: state.badge
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
