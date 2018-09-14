import React, { Component } from 'react';
import {
  Link,
  withRouter,
} from 'react-router-dom';

import { auth, firebase, firestore } from '../Firebase';

import * as routes from '../../routes/routes';

const SignUpPage = ({ history }) =>
  <div className="content content-with-padding register-form-content">
    {/* <h1>SignUp</h1> */}
    <SignUpForm history={history} />
  </div>

const INITIAL_STATE = {
  firstname: '',
  lastname: '',
  email: '',
  passwordOne: '',
  passwordTwo: '',
  accepted: false,
  error: null,
};

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value,
});


class SignUpForm extends Component {
  constructor(props) {
    super(props);
    this.state = { ...INITIAL_STATE };
  }

  onSubmit = (event) => {
    event.preventDefault();

    const {
      firstname,
      lastname,
      email,
      // birthday,
      // education,
      institute,
      passwordOne,
      accepted
    } = this.state;

    const {
      history,
    } = this.props;

    let user = new Object();
    user["name"] = firstname+" "+lastname;
    user["email"] = email;
    // user["birthday"] = birthday;
    // user["education"] = education;
    user["institute"] = institute;
    user["favorites"] = [];

    console.log(user);

    var self = this;

    auth.doCreateUserWithEmailAndPassword(email, passwordOne)
      .then(authUser => {
        console.log(auth.getUserId());
        self.setState(() => ({ ...INITIAL_STATE }));
      })
      .catch(error => {
        self.setState(byPropKey('error', error));
      });
    
    firebase.auth.onAuthStateChanged(authUser => {
      authUser
          ? firestore.createNewParticipant(authUser.uid, user)
          .then(res => {
            history.push(routes.FrontPage);
          })
          .catch(error => {
            console.log('Error: Could not create participant: ', error);
          })
          : console.log("authUser is null");
    });

  }

  render() {
    const {
      firstname,
      lastname,
      email,
      // birthday,
      // education,
      institute,
      passwordOne,
      passwordTwo,
      accepted,
      error,
    } = this.state;

    const isInvalid =
      passwordOne !== passwordTwo
      || passwordOne === ''
      || email === ''
      || firstname === ''
      || lastname === ''
      // || ! /^(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/.test(birthday)
      // || education === ''
      || institute === ''
      || accepted == false
      ;

    return (
      <div id="register-form">
        <div class="cl-wh" id="f-mlb">Maak een account</div>
        <form onSubmit={this.onSubmit}>
          <div className="form-group">
            <label class="cl-wh f-lb">E-mailadres:</label>
            <div class="f-i-bx b3 mrg3b">
              <div class="tb">
                  <div class="td icon"><i class="fas fa-envelope"></i></div>
                  <div class="td prt">
                    <input
                      value={email}
                      onChange={event => this.setState(byPropKey('email', event.target.value))}
                      type="text"
                      placeholder="Email"
                    />
                  </div>
                </div>
              </div>
            </div>
          <div className="form-group">
            <label class="cl-wh f-lb">Naam:</label>
            <div class="f-i-bx b3 mrg3b">
              <div class="tb">
                  <div class="td icon"><i class="fas fa-user"></i></div>
                  <div class="td prt">
                  <input
                    value={firstname}
                    onChange={event => this.setState(byPropKey('firstname', event.target.value))}
                    type="text"
                    placeholder="Voornaam"
                  />
                </div>
              </div>
            </div>
            <div class="f-i-bx b3 mrg3b">
                <div class="tb">
                    <div class="td icon"><i class="fas fa-user"></i></div>
                    <div class="td prt">
                    <input
                      value={lastname}
                      onChange={event => this.setState(byPropKey('lastname', event.target.value))}
                      type="text"
                      placeholder="Achternaam"
                    />
                  </div>
              </div>
            </div>
          </div>
          {/* <div className="form-group">
            Geboortedatum:
            <input
              value={birthday}
              onChange={event => this.setState(byPropKey('birthday', event.target.value))}
              type="date"
              placeholder="YYYY-MM-DD"
            />
            </div> */}
          {/* <div className="form-group">
            Educatie:
            <input
              value={education}
              onChange={event => this.setState(byPropKey('education', event.target.value))}
              type="text"
              placeholder="Educatie"
            />
            </div> */}
          <div className="form-group">
            <label class="cl-wh f-lb">Organisatie/onderwijsinstelling:</label>
            <div class="f-i-bx b3 mrg3b">
              <div class="tb">
                <div class="td icon"><i class="fas fa-building"></i></div>
                <div class="td prt">
                  <input
                    value={institute}
                    onChange={event => this.setState(byPropKey('institute', event.target.value))}
                    type="text"
                    placeholder="Organisatie/onderwijsinstelling"
                  />
                </div>
              </div>
            </div>
          </div>
          <div className="form-group">
          <label class="cl-wh f-lb">Wachtwoord:</label>
            <div class="f-i-bx b3 mrg3b">
              <div class="tb">
                <div class="td icon"><i class="fas fa-lock"></i></div>
                <div class="td prt">
                  <input
                    value={passwordOne}
                    onChange={event => this.setState(byPropKey('passwordOne', event.target.value))}
                    type="password"
                    placeholder="Wachtwoord"
                  />
                </div>
              </div>
            </div>
            <div class="f-i-bx b3 mrg3b">
              <div class="tb">
                <div class="td icon"><i class="fas fa-lock"></i></div>
                <div class="td prt">
                  <input
                    value={passwordTwo}
                    onChange={event => this.setState(byPropKey('passwordTwo', event.target.value))}
                    type="password"
                    placeholder="Herhaal wachtwoord"
                  />
                </div>
              </div>
            </div>
          </div>
          {/* <div className="form-group">
            Ik ga akkoord met het <a target="_blank" rel="noopener noreferrer" href="/privacy">privacybeleid</a>:
            <input
              value={accepted}
              onChange={event => this.setState(byPropKey('accepted', event.target.value))}
              type="checkbox"
              placeholder="Instituut"
            />
          </div> */}
          <div id="tc-bx">Je gaat akkoord met onze <a href={routes.Voorwaarden}>voorwaarden</a> &amp; <a href={routes.Privacy}>privacy beleid</a>.</div>
          <div id="s-btn" class="mrg25t"><input type="submit" value="Sign up" class="b3"/></div>
          { error && <p>{error.message}</p> }
        </form>
      </div>
    );
  }
}

const SignUpLink = () =>
  <p>
    Don't have an account?
    {' '}
    <Link to={routes.Register}>Sign Up</Link>
  </p>

export default withRouter(SignUpPage);

export {
  SignUpForm,
  SignUpLink,
};