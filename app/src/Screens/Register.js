import React, { Component } from 'react';
import { connect } from 'react-redux';

import { UserRegister } from './../actions/authActions';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

import FormRegisterUser from './../Components/Auth/FormRegisterUser';

class Register extends Component {
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
				<Nav/>
					<div className="container">
						<div className="content">
              <h1>Register</h1>
              <div className="form" id="register_user">
                <FormRegisterUser onSubmit={this.handleSubmit}/>
              </div>
            </div>
					</div>
				<Footer/>
			</React.Fragment>
		)
	}
}

export default (Register = connect(
  (state) => {
    return {
      form: state.form
    };
  },
  (dispatch) => {
    return {
      registerUser: (data) => {
        dispatch(UserRegister(data));
      },
    };
  }
)(Register));
