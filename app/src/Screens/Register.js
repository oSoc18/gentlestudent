import React, { Component } from 'react';

import Nav from './../Components/Nav';
import Footer from './../Components/Footer';

class Register extends Component {
  constructor(props) {
    super(props)
    this.submit = this.submit.bind(this);
  }
  submit(e) {
    console.log('submit');
    fetch('http://localhost:8080/api/v1/auth/register', {
      method: 'POST',
      body: {
        "email": "ismail.kutlu94@gmail.com",
        "localProvider": {
          "password": "test123"
        }
      }
    })
  }
  render() {
		return (
			<div>
				<Nav/>
					<div className="container">
						<div className="content">
							<h1>Register</h1>
              <form action="register">
                <div>
                  <label>Username:</label>
                  <input type="text" name="username"/>
                </div>
                <div>
                    <label>Password:</label>
                    <input type="password" name="password"/>
                </div>
                <div>
                  <button type="submit" onSubmit={(e) => {
                    if (e.keyCode === 13) {
                      e.preventDefault();
                    }
                    this.submit();
                  }}>
                    Log In
                  </button>
                </div>
              </form>
						</div>
					</div>
				<Footer/>
			</div>
		)
	}
}

export default Register;