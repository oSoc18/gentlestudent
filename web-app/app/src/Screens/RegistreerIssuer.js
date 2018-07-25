import React, { Component } from 'react';
import { connect } from 'react-redux';

import FormRegisterUser from './../Components/Auth/RegistreerIssuer';

class RegistreerIssuer extends Component {
  constructor(props) {
    super(props)
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  handleSubmit() {
    console.log('credentials: ', {...this.props.form.registerUser.values});
    this.props.registerUser(
      {
        email: this.props.form.registerUser.values.email,
        localProvider: {
          password: this.props.form.registerUser.values.password
        }
      }
    );
  }
  render() {
		return (
			<React.Fragment>
        <div className="container">
          <div className="content">
            <h1>Word issuer</h1>
            <div className="form" id="register_user">
              <FormRegisterUser onSubmit={this.handleSubmit}/>
            </div>
          </div>
        </div>
			</React.Fragment>
		)
	}
}

export default RegistreerIssuer;
