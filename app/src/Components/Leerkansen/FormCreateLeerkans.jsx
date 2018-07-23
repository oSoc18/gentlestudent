import React, { Component } from 'react';
import LocationPicker from 'react-location-picker';

import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import Spinner from '../Spinner';

import { renderInput, renderTextarea, renderSelect, RenderDropzoneInput } from './../Utils';

/* Default position */
const defaultPosition = {
  lat: 51.0511164,
  lng: 3.7114566
};

class FormCreateLeerkans extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      value: 'coconut', 
      lat: 51.0511164,
      lng: 3.7114566
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
          />
        </div>
        <div className="form-group">
          <Field
            label="Korte beschrijving van wat er verwacht wordt"
            type="text"
            name="synopsis"
            id="synopsis"
            component={renderTextarea}
          />
        </div>
        <div className="form-group">
          <Field
            label="Volledige beschrijving van de leerkans"
            id="description"
            name="description"
            component={renderTextarea}
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
            label="Start datum (DD/MM/JJJJ)"
            id="start_date"
            name="start_date"
            defaultValue="01/03/2018"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Eind datum (DD/MM/JJJJ)"
            id="end_date"
            name="end_date"
            defaultValue="01/06/2018"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Straatnaam"
            id="street"
            name="street"
            defaultValue="Rooigemlaan"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Huisnummer"
            id="house_number"
            name="house_number"
            defaultValue="123"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Post code"
            id="postal_code"
            name="postal_code"
            defaultValue="9000"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Stad"
            id="city"
            name="city"
            defaultValue="Gent"
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Land"
            id="country"
            name="country"
            defaultValue="Belgie"
            component={renderInput}
          />
        </div>
        <h3> Pas locatie aan (Optioneel) </h3>
        Verplaats de marker indien de locatie van het adres op google maps niet volledig overeenkomt met de beacon
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
            component={renderInput}
          />
        </div>
        <div className="form-group">
          <Field
            label="Longitude (automatisch)"
            id="longitude"
            name="longitude"
            defaultValue={this.state.lng}
            value={this.state.lng}
            component={renderInput}
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
    this.props.changeLat(position.lat);
    this.props.changeLng(position.lng);
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