import React, { Component } from 'react';
import { connect } from 'react-redux';

import FormRegisterUser from './../Components/Auth/FormRegisterUser';

class Register extends Component {
  constructor(props) {
    super(props)
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  componentDidMount(){
    window.scrollTo(0, 0);
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
          <div className="content content-with-padding">
            <h1>Register</h1>
            <div className="form" id="register_user">
              <FormRegisterUser onSubmit={this.handleSubmit}/>
            </div>
          </div>
        </div>
			</React.Fragment>
		)
	}
}

export default Register;
