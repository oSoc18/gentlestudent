import React, { Component } from 'react';

import FormRegisterUser from './RegistreerIssuer';

class RegistreerIssuer extends Component {
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
        <div className="content content-with-padding register-form-content">
          <div className="register-form">
            <div class="cl-wh" id="f-mlb">Word issuer</div>
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
