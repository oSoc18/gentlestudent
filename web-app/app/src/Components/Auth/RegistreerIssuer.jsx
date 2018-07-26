import React, { Component } from 'react';
import {
  Link,
  withRouter,
} from 'react-router-dom';

import { firestore } from '../Firebase';
import { auth } from '../Firebase';
import { firebase } from '../Firebase';
import * as routes from '../../routes/routes';

const INITIAL_STATE = {
  institution: '',
  longName: '',
  url: '',
  phonenumber: '',
  street: '',
  housenumber: '',
  bus: '',
  postalcode: '',
  city: ''
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
    event.preventDefault();
    const {
        institution,
        longName,
        url,
        phonenumber,
        street,
        housenumber,
        bus,
        postalcode,
        city
    } = this.state;

    const {
      history,
    } = this.props;
    var userId = auth.getUserId();
    var userEmail = auth.getUserEmail();
    firestore.createIssuer(institution, longName, url, phonenumber, street, housenumber, bus, postalcode, city, userId, userEmail)
      .then(authUser => {
        this.setState(() => ({ ...INITIAL_STATE }));
        history.push(routes.FrontPage);
      })
      .catch(error => {
        this.setState(byPropKey('error', error));
      });

  }

  render() {
    const {
      institution,
      longName,
      url,
      phonenumber,
      street,
      housenumber,
      bus,
      postalcode,
      city
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
          placeholder="Telefoonnummer"
        />
        <input
            value={street}
            onChange={event => this.setState(byPropKey('street', event.target.value))}
            type="text"
            placeholder="Straat"
        />
        <input
            value={housenumber}
            onChange={event => this.setState(byPropKey('housenumber', event.target.value))}
            type="number"
            placeholder="Huisnummer"
        />
        <input
            value={bus}
            onChange={event => this.setState(byPropKey('bus', event.target.value))}
            type="text"
            placeholder="Bus"
        />
        <input
            value={postalcode}
            onChange={event => this.setState(byPropKey('postalcode', event.target.value))}
            type="number"
            placeholder="Postcode"
        />
        <input
            value={city}
            onChange={event => this.setState(byPropKey('city', event.target.value))}
            type="text"
            placeholder="Stad"
        />
        <button type="submit">
          Word issuer
        </button>
      </form>
    );
  }
}
export default withRouter(RegistreerIssuer);
