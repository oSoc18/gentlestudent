import React, { Component } from 'react';
import { connect } from 'react-redux';

import { UserLogin } from './../actions/authActions';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

import FormLoginUser from './../Components/Auth/FormLoginUser';

class Login extends Component {
  constructor(props) {
    super(props)
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  handleSubmit() {
    console.log('credentials: ', {...this.props.form.loginUser.values});
    this.props.loginUser(
      {
        email: this.props.form.loginUser.values.email,
        password: this.props.form.loginUser.values.password
      }
    );
  }
  render() {
		return (
			<React.Fragment>
				<Nav/>
					<div className="container">
						<div className="content">
              <h1>Login</h1>
              <div className="form" id="login_user">
                <FormLoginUser onSubmit={this.handleSubmit}/>
              </div>
            </div>
					</div>
				<Footer/>
			</React.Fragment>
		)
	}
}

export default (Login = connect(
  (state) => {
    return {
      form: state.form
    };
  },
  (dispatch) => {
    return {
      loginUser: (data) => {
        dispatch(UserLogin(data));
      },
    };
  }
)(Login));
