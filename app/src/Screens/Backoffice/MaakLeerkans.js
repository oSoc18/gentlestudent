import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import FormCreateLeerkans from './../../Components/Leerkansen/FormCreateLeerkans';

import { firestore } from './../../Components/Firebase';

class CreateLeerkans extends Component {
  constructor() {
    super();
    this.submit = this.submit.bind(this);
    this.state = {
		  badges: null,
		};
  };
  componentDidMount() {
		firestore.onceGetBadges().then(snapshot => {
			var res = new Object();
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ badges: res }))
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
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
    const { badges } = this.state;

    return (
      <div>
        <div className="container">
          <div className="content">
            <Link to="/backoffice/leerkansen">Back</Link>
            <h1>Maak Leerkans</h1>
            <div className="form" id="create_leerkans">
              <FormCreateLeerkans onSubmit={this.submit} badges={badges}/>
            </div>
          </div>
        </div>
    </div>
    );
  }
}

export default CreateLeerkans;
