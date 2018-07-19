import React, { Component } from 'react';
import {
  Link,
  withRouter,
} from 'react-router-dom';

import { auth } from '../Firebase';
import * as routes from '../../routes/routes';

const INITIAL_STATE = {
  institution: '',
  longName: '',
  url: '',
  phonenumber: null,
};

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value,
});

class RegistreerIssuer extends Component {
  constructor(props) {
    super(props);
    this.state = { ...INITIAL_STATE };
  }

  onSubmit = (event) => {
    const {
        institution,
        longName,
        url,
        phonenumber
    } = this.state;

    const {
      history,
    } = this.props;

  /*  auth.doCreateUserWithEmailAndPassword(email, passwordOne)
      .then(authUser => {
        this.setState(() => ({ ...INITIAL_STATE }));
        history.push(routes.WordIssuer);
      })
      .catch(error => {
        this.setState(byPropKey('error', error));
      });

    event.preventDefault();*/
  }

  render() {
    const {
      institution,
      longName,
      url,
      phonenumber
    } = this.state;

    return (
      <form onSubmit={this.onSubmit}>
        <input
          value={institution}
          onChange={event => this.setState(byPropKey('institution', event.target.value))}
          type="text"
          placeholder="Bedrijfsnaam voor op badge"
        />
        <input
          value={longName}
          onChange={event => this.setState(byPropKey('longName', event.target.value))}
          type="text"
          placeholder="Volledige bedijfsnaam"
        />
        <input
          value={url}
          onChange={event => this.setState(byPropKey('url', event.target.value))}
          type="text"
          placeholder="URL bedrijf"
        />
        <input
          value={phonenumber}
          onChange={event => this.setState(byPropKey('phonenumber', event.target.value))}
          type="text"
          placeholder="telefoonnummer"
        />
        <button type="submit">
          Word issuer
        </button>
      </form>
    );
  }
}
export default withRouter(RegistreerIssuer);
