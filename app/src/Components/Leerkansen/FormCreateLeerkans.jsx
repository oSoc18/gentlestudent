import React, { Component } from 'react';
import LocationPicker from 'react-location-picker';
import Geocode from "react-geocode";

import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import Spinner from '../Spinner';

import { auth, firestore } from './../Firebase';
import firebase from 'firebase';
import 'firebase/storage';

import { Category, Difficulty} from './Constants';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput } from './../Utils';

// set Google Maps Geocoding API for purposes of quota management. Its optional but recommended.
Geocode.setApiKey(process.env.REACT_APP_GOOGLE_MAPS_API_KEY);

/* Default position */
var defaultPosition = {
  lat: 51.0511164,
  lng: 3.7114566
};

class FormCreateLeerkans extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      lat: 51.0511164,
      lng: 3.7114566,
      badgeId: "",
      category: 0,
      difficulty: 0,
      address: '',
      street: "",
      house_number: "",
      city: "",
      postal_code: "",
      country: "Belgium",
      start_date: "",
      end_date: "",
      description: "",
      synopsis: "",
      title: "",
      image: "",
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunity%20Images%2FNederlandse%20Les.jpg?alt=media&token=7938b826-8407-4659-8cfa-ee6fb139d448",
      imageExtension: ""
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleImage = this.handleImage.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.changeLat = this.changeLat.bind(this);
    this.changeLng = this.changeLng.bind(this);
    this.postNewAddress = this.postNewAddress.bind(this);
    this.postNewOpportunity = this.postNewOpportunity.bind(this);
    this.uploadImage = this.uploadImage.bind(this);
    this.choosePin = this.choosePin.bind(this);
  }

  choosePin(){
    let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Pins%2F";
    let url = baseUrl;
    switch(this.state.category){
      case 0: url += "pin_digitale-geletterdheid";
      case 1: url += "pin_duurzaamheid";
      case 2: url += "pin_ondernemingszin";
      case 3: url += "pin_onderzoekende-houding";
      case 4: url += "pin_wereldburgerschap";
    }
    switch(this.state.difficulty){
      case 0: url += "_1.png?alt=media";
      case 1: url += "_2.png?alt=media";
      case 2: url += "_3.png?alt=media";
    }
    this.setState({pinImageUrl: url});
  }

  handleChange(event) {
    this.setState({[event.target.id]: event.target.value});
    // console.log(event.target.id);
    // console.log(event.target.value);
    if(event.target.id=="street" 
      || "house_number" 
      || "city" 
      || "postal_code" 
      || "country" ){
      this.changeAddress();
    }
  }

  handleImage(event) {
    this.setState({image: event.target.files[0]});
    this.setState({imageExtension: event.target.value.split('.').pop()});
  }

  handleSubmit(event) {
    event.preventDefault();
    this.choosePin();
    if(this.state.image != ""){
      let fileName = this.state.title+"."+this.state.imageExtension;
      let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunity%20Images%2F";
      this.setState({imageUrl: baseUrl + encodeURIComponent(fileName)+"?alt=media"});
      this.uploadImage(fileName);
    }
    this.postNewAddress(this.postNewOpportunity);
  }

  uploadImage(fileName){
    console.log(fileName);
    let path = "Opportunity Images/"+fileName;
    let ref = firebase.storage().ref().child(path);
    ref.put(this.state.image).then(function(snapshot) {
      console.log('Uploaded file!');
    }).catch(function(error) {
      console.error("Error uploading file: ", error);
    });
  }

  postNewAddress(postNewOpportunity){
    let address = new Object();
    address["bus"] = "";
    address["city"] = this.state.city;
    address["housenumber"] = this.state.house_number;
    address["postalcode"] = this.state.postal_code;
    address["street"] = this.state.street;
    address["country"] = this.state.country;

    firestore.createAddress(address).then(function(docRef) {
      console.log("Document written with ID: ", docRef.id);
      postNewOpportunity(docRef.id);
    }).catch(function(error) {
      console.error("Error adding document: ", error);
    });
  }

  postNewOpportunity(addressId){
    let opportunity = new Object();
    opportunity["addressId"] = addressId;
    opportunity["badgeId"] = this.state.badgeId;
    opportunity["beginDate"] = this.state.start_date;
    opportunity["blocked"] = true;
    opportunity["category"] = this.state.category;
    opportunity["difficulty"] = this.state.difficulty;
    opportunity["endDate"] = this.state.end_date;
    opportunity["international"] = false;
    opportunity["issuerId"] = auth.getUserId();
    opportunity["latitude"] = this.state.lat;
    opportunity["longDescription"] = this.state.description;
    opportunity["longitude"] = this.state.lng;
    opportunity["oppImageUrl"] = this.state.imageUrl;
    opportunity["pinImageUrl"] = "";
    opportunity["shortDescription"] = this.state.synopsis;
    opportunity["title"] = this.state.title;

    firestore.createOpportunity(opportunity)
    .catch(function(error) {
      console.error("Error adding document: ", error);
      console.error(JSON.stringify(opportunity));
    });
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
            id="title"
            component={renderInput}
            defaultValue="Titel"
            placeholder="Titel"
            value={this.state.title}
            onChange={ this.handleChange }
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
            value={this.state.synopsis}
            onChange={ this.handleChange }
          />
        </div>
        <div className="form-group">
          <Field
            label="Beschrijving"
            id="description"
            name="description"
            component={renderTextarea}
            placeholder="Volledige beschrijving van de leerkans"
            value={this.state.description}
            onChange={ this.handleChange }
          />
        </div>
        {/* <div className="form-group">
          <React.Fragment>
            { !! badges && <BadgesList badges={ badges } /> }
            { ! badges && <EmptyList/> }
          </React.Fragment>
        </div> */}
        <div className="form-group">
          <Field
            id="category"
            name="Category"
            label="Categorie"
            data={{
              list: Object.keys(Category).map(key => {
                return {
                  value: Category.key,
                  display: key
                };
              })
            }}
            component={renderSelect}
          />
        </div>
        <div className="form-group">
          <Field
            id="difficulty"
            name="Difficulty"
            label="Moeilijkheidsgraad"
            data={{
              list: Object.keys(Difficulty).map(key => {
                return {
                  value: Difficulty.key,
                  display: key
                };
              })
            }}
            component={renderSelect}
          />
        </div>
        <div className="form-group">
          <Field
            label="Start datum"
            id="start_date"
            name="start_date"
            defaultValue="01/03/2018"
            component={renderInput}
            placeholder="DD/MM/JJJJ"
            value={this.state.start_date}
            onChange={ this.handleChange }
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
            value={this.state.end_date}
            onChange={ this.handleChange }
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
            onChange={ this.handleChange }
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
            value={this.state.house_number}
            onChange={ this.handleChange }
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
            value={this.state.postal_code}
            onChange={ this.handleChange }
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
            onChange={this.handleChange }
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
            onChange={ this.handleChange } 
          />
        </div>
        <div className="form-group">
          <label htmlFor="LocationPicker">
            Pas locatie aan (Optioneel)
          </label>
          <p>Verplaats de marker indien de locatie van het adres op google maps niet volledig overeenkomt met de beacon</p>
          <div>
            <BeaconLocationPicker changeLat={this.changeLat} changeLng={this.changeLng}/>
          </div>
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
        {/* <div className="form-group">
          <Field
            name="image"
            component={RenderDropzoneInput}
          />
        </div> */}
        <div className="form-group">
          <label htmlFor="Image">
            Afbeelding uploaden
          </label>
          <input 
            type="file"
            label="Afbeelding uploaden"
            className="input"
            id="image"
            onChange={ this.handleImage } 
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
    id="badgeId"
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