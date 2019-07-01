import React, { Component } from 'react';
import {
  Link,
  withRouter,
} from 'react-router-dom';

import { auth, firebase, firestore } from '../../../Utils/Firebase';
import * as routes from '../../../routes/routes';

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
      city,
      error
    } = this.state;

    return (
      <form onSubmit={this.onSubmit}>
        <div className="form-group">
          <label class="cl-wh f-lb">Organisatie:</label>
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-building"></i></div>
              <div class="td prt">
                <input
                  value={institution}
                  onChange={event => this.setState(byPropKey('institution', event.target.value))}
                  type="text"
                  placeholder="Bedrijfsnaam voor op badge"
                />
              </div>
            </div>
          </div>
        </div>
        <div className="form-group">
          <label class="cl-wh f-lb">Volledige bedijfsnaam:</label>
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-building"></i></div>
              <div class="td prt">
                <input
                  value={longName}
                  onChange={event => this.setState(byPropKey('longName', event.target.value))}
                  type="text"
                  placeholder="Volledige bedijfsnaam"
                />
              </div>
            </div>
          </div>
        </div>
        <div className="form-group">
          <label class="cl-wh f-lb">Website:</label>
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-globe"></i></div>
              <div class="td prt">
                <input
                  value={url}
                  onChange={event => this.setState(byPropKey('url', event.target.value))}
                  type="text"
                  placeholder="URL bedrijf"
                />
              </div>
            </div>
          </div>
        </div>
        <div className="form-group">
          <label class="cl-wh f-lb">Telefoonnummer:</label>
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-phone"></i></div>
              <div class="td prt">
                <input
                  value={phonenumber}
                  onChange={event => this.setState(byPropKey('phonenumber', event.target.value))}
                  type="text"
                  placeholder="Telefoonnummer"
                />
              </div>
            </div>
          </div>
        </div>
        <div className="form-group">
          <label class="cl-wh f-lb">Adres:</label>
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-road"></i></div>
              <div class="td prt">
                <input
                  value={street}
                  onChange={event => this.setState(byPropKey('street', event.target.value))}
                  type="text"
                  placeholder="Straat"
                />
              </div>
            </div>
          </div>
        {/* </div> */}
        {/* <div className="form-group"> */}
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-home"></i></div>
              <div class="td prt">
                <input
                  value={housenumber}
                  onChange={event => this.setState(byPropKey('housenumber', event.target.value))}
                  type="number"
                  placeholder="Huisnummer"
                />
              </div>
            </div>
          </div>
        {/* </div> */}
        {/* <div className="form-group"> */}
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-envelope"></i></div>
              <div class="td prt">
                <input
                  value={bus}
                  onChange={event => this.setState(byPropKey('bus', event.target.value))}
                  type="text"
                  placeholder="Bus"
                />
              </div>
            </div>
          </div>
        {/* </div> */}
        {/* <div className="form-group"> */}
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-map-marker"></i></div>
              <div class="td prt">
                <input
                  value={postalcode}
                  onChange={event => this.setState(byPropKey('postalcode', event.target.value))}
                  type="number"
                  placeholder="Postcode"
                />
              </div>
            </div>
          </div>
        {/* </div> */}
        {/* <div className="form-group"> */}
          <div class="f-i-bx b3 mrg3b">
            <div class="tb">
              <div class="td icon"><i class="fas fa-map-marker"></i></div>
              <div class="td prt">
                <input
                  value={city}
                  onChange={event => this.setState(byPropKey('city', event.target.value))}
                  type="text"
                  placeholder="Stad"
                />
              </div>
            </div>
          </div>
        </div>
        <div id="s-btn" class="mrg25t submit-padding"><input type="submit" value="Word issuer" class="b3"/></div>
        { error && <p>{error.message}</p> }
      </form>
    );
  }
}
export default withRouter(RegistreerIssuer);
