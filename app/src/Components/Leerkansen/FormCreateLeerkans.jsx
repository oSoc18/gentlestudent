import React, { Component } from 'react';
import LocationPicker from 'react-location-picker';
import Geocode from "react-geocode";

import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import Spinner from '../Spinner';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput } from './../Utils';

// set Google Maps Geocoding API for purposes of quota management. Its optional but recommended.
Geocode.setApiKey("AIzaSyALLWUxYAWdEzUoSuWD8j2gVGRR05SWpe8");

/* Default position */
var defaultPosition = {
  lat: 51.0511164,
  lng: 3.7114566
};

class FormCreateLeerkans extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      value: 'coconut', 
      lat: 51.0511164,
      lng: 3.7114566,
      address: '',
      street: "Veldstraat",
      houseNr: "1",
      city: "Ghent",
      postCode: "9000",
      country: "Belgium"
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.changeLat = this.changeLat.bind(this);
    this.changeLng = this.changeLng.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    alert('Your favorite flavor is: ' + this.state.value);
    event.preventDefault();
  }

  changeLat(newLat) {
    this.setState({
      lat: newLat
    })
  }

  changeLng(newLng) {
    this.setState({
      lng: newLng
    })
  }

  changeStreet(event) {
    this.setState({street: event.target.value});
    this.changeAddress();
  }

  changeHouseNr(event) {
    this.setState({houseNr: event.target.value});
    this.changeAddress();
  }

  changePostCode(event) {
    this.setState({postCode: event.target.value});
    this.changeAddress();
  }

  changeCity(event) {
    this.setState({city: event.target.value});
    this.changeAddress();
  }

  changeCountry(event) {
    this.setState({country: event.target.value});
    this.changeAddress();
  }

  changeAddress() {
    Geocode.fromAddress(this.state.street+" "+this.state.houseNr+", "+this.state.city+" "+this.state.postCode+", "+this.state.country).then(
      response => {
        const { lat, lng } = response.results[0].geometry.location;
        this.setState({lat: lat});
        this.setState({lng: lng});
        defaultPosition = {lat, lng};
      },
      error => {
        console.error(error);
      }
    );
  }

  render() {
    const { 
      handleSubmit,
      submitting,
      badge,
      badges
    } = this.props

    return (
      <form onSubmit={this.handleSubmit}>
        {/* <h2>(Loop all the fields before submitting -- will be fixed soon!)</h2> */}
        <div className="form-group">
          <Field
            label="Titel"
            type="text"
            name="title"
            component={renderInput}
            defaultValue="Titel"
            placeholder="Titel"
          />
        </div>
        <div className="form-group">
          <Field
            label="Verwachtingen"
            type="text"
            name="synopsis"
            id="synopsis"
            component={renderTextarea}
            placeholder="Korte beschrijving van wat er verwacht wordt"
          />
        </div>
        <div className="form-group">
          <Field
            label="Beschrijving"
            id="description"
            name="description"
            component={renderTextarea}
            placeholder="Volledige beschrijving van de leerkans"
          />
        </div>
        <div className="form-group">
          <React.Fragment>
            { !! badges && <BadgesList badges={ badges } /> }
            { ! badges && <EmptyList/> }
          </React.Fragment>
        </div>
        <div className="form-group">
          <Field
            label="Start datum"
            id="start_date"
            name="start_date"
            defaultValue="01/03/2018"
            component={renderInput}
            placeholder="DD/MM/JJJJ"
          />
        </div>
        <div className="form-group">
          <Field
            label="Eind datum"
            id="end_date"
            name="end_date"
            defaultValue="01/06/2018"
            component={renderInput}
            placeholder="DD/MM/JJJJ"
          />
        </div>
        <div className="form-group">
          <Field
            label="Straatnaam"
            id="street"
            name="street"
            defaultValue="Rooigemlaan"
            component={renderInput}
            placeholder="Straatnaam"
            value={this.state.street}
            onChange={ this.changeStreet.bind(this) }
          />
        </div>
        <div className="form-group">
          <Field
            label="Huisnummer"
            id="house_number"
            name="house_number"
            defaultValue="123"
            component={renderInput}
            placeholder="Huisnummer"
            value={this.state.houseNr}
            onChange={ this.changeHouseNr.bind(this) }
          />
        </div>
        <div className="form-group">
          <Field
            label="Post code"
            id="postal_code"
            name="postal_code"
            defaultValue="9000"
            component={renderInput}
            placeholder="Post code"
            value={this.state.postcode}
            onChange={ this.changePostCode.bind(this) }
          />
        </div>
        <div className="form-group">
          <Field
            label="Stad"
            id="city"
            name="city"
            defaultValue="Gent"
            component={renderInput}
            placeholder="Stad"
            value={this.state.city}
            onChange={this.changeCity.bind(this)}
          />
        </div>
        <div className="form-group">
          <Field
            label="Land"
            id="country"
            name="country"
            defaultValue="Belgie"
            component={renderInput}
            placeholder="Land"
            value={this.state.country}
            onChange={ this.changeCountry.bind(this) } 
          />
        </div>
        <h3> Pas locatie aan (Optioneel) </h3>
        <p>Verplaats de marker indien de locatie van het adres op google maps niet volledig overeenkomt met de beacon</p>
        <div>
          <BeaconLocationPicker changeLat={this.changeLat} changeLng={this.changeLng}/>
        </div>
        <div className="form-group">
          <Field
            label="Latitude (automatisch)"
            id="latitude"
            name="latitude"
            defaultValue={this.state.lat}
            value={this.state.lat}
            component={renderAutomaticInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Longitude (automatisch)"
            id="longitude"
            name="longitude"
            defaultValue={this.state.lng}
            value={this.state.lng}
            component={renderAutomaticInput}
          />
        </div>
        <div className="form-group">
          <Field
            name="image"
            component={RenderDropzoneInput}
          />
        </div>
        <div className="form-group">
          <button type="submit" disabled={submitting}>
            Maak leerkans
          </button>
        </div>
      </form>
    );
  }
}

const BadgesList = ({badges}) =>
  <Field
    id="badge"
    name="badge"
    label="Badge"
    data={{
      list: Object.keys(badges).map(key => {
        return {
          value: key,
          display: badges[key].name
        };
      })
    }}
    component={renderSelect}
  />

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

class BeaconLocationPicker extends Component {
  constructor (props) {
    super(props);

    this.state = {
      address: "Kala Pattar Ascent Trail, Khumjung 56000, Nepal",
      position: {
         lat: 0,
         lng: 0
      }
    };
 
    // Bind
    this.handleLocationChange = this.handleLocationChange.bind(this);
  }
  
  handleLocationChange ({ position, address }) {
 
    // Set new location
    this.setState({ position, address });
    if(!!position){
      this.props.changeLat(position.lat);
      this.props.changeLng(position.lng);
    }
  }
 
  render () {
    return (
      <div>
        {/* <h1>{this.state.address}</h1> */}
        <div>
          <LocationPicker
            containerElement={ <div style={ {height: '100%'} } /> }
            mapElement={ <div style={ {height: '400px'} } /> }
            defaultPosition={defaultPosition}
            onChange={this.handleLocationChange}
          />
        </div>
      </div>
    )
  }
}

FormCreateLeerkans = reduxForm({
  form: 'createLeerkansForm',
  fields: ['title', 'synopsis']
})(FormCreateLeerkans);

export default FormCreateLeerkans;