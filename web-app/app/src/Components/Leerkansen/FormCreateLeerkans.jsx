import React, { Component } from 'react';
import LocationPicker from 'react-location-picker';
import Geocode from "react-geocode";

import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form/immutable';
import Spinner from '../Spinner';

import { auth, firestore } from './../Firebase';
import firebase from 'firebase';
import 'firebase/storage';

import { Category, Difficulty} from './Constants';

import * as routes from '../../routes/routes';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput, validate } from './../Utils';
// import { FirebaseStorage } from '@firebase/storage-types';

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
      house_number: 0,
      city: "",
      postal_code: 0,
      country: "Belgium",
      start_date: "",
      end_date: "",
      description: "",
      synopsis: "",
      title: "dfsfd",
      image: "",
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunityimages%2FNederlandse%20Les.jpg?alt=media&token=82cecaa7-4d6e-473d-b06a-a5eea35d8d4b",
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
    // this.componentDidMount = this.componentDidMount.bind(this);
  }

  // componentDidMount() {
  //   this.setState({title: "skjsd"});
  //   var self = this;
    // if(this.props.match!=undefined){
    //   try{
    //     const id = this.props.match.params.id;
    //     console.log("fetching opportunity data");
    //     firestore.onceGetOpportunity(id).then(snapshot => {
    //       console.log(JSON.stringify(snapshot.data()));
    //       if(snapshot.data()==undefined){
    //           throw "Could not fetch data";
    //       }
    //       self.setState(() => ({ 
            // addressId: snapshot.data().addressId,
            // beginDate: snapshot.data().beginDate,
            // category: self.getEnumValue(Category, snapshot.data().category),
            // difficulty: self.getEnumValue(Difficulty, snapshot.data().difficulty),
            // endDate: snapshot.data().endDate,
            // longDescription: snapshot.data().longDescription,
            // oppImageUrl: snapshot.data().oppImageUrl,
            // shortDescription: snapshot.data().shortDescription,
            // title: snapshot.data().shortDescription,
    //       }));
    //     }).catch(function(error) {
    //       console.error("Error getting document: ", error);
    //     });
    //   }
    //   catch(e){
    //     console.log("error fetching opportunity", e)
    //   }
    // }
  // }

  getEnumValue(enumTable, i){
    var keys = Object.keys(enumTable).sort(function(a, b){
      return enumTable[a] - enumTable[b];
    }); //sorting is required since the order of keys is not guaranteed.
    
    var getEnum = function(ordinal) {
      return keys[ordinal];
    }

    return getEnum(i);
  }

  choosePin(){
    let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Pins%2F";
    let url = baseUrl;
    switch(parseInt(this.state.category)){
      case 0: url += "pin_digitale-geletterdheid"; break;
      case 1: url += "pin_duurzaamheid"; break;
      case 2: url += "pin_ondernemingszin"; break;
      case 3: url += "pin_onderzoekende-houding"; break;
      case 4: url += "pin_wereldburgerschap"; break;
    }
    switch(parseInt(this.state.difficulty)){
      case 0: url += "_1.png?alt=media"; break;
      case 1: url += "_2.png?alt=media"; break;
      case 2: url += "_3.png?alt=media"; break;
    }
    this.setState({pinImageUrl: url});
  }

  handleChange(event) {
    // console.log(event.target.value);
    this.setState({[event.target.id]: event.target.value});
    // this.event.target.props.change(value, )
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
      let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunityimages%2F";
      this.setState({imageUrl: baseUrl + encodeURIComponent(fileName)+"?alt=media"});
      this.uploadImage(fileName);
    }
    this.postNewAddress(this.postNewOpportunity);
  }

  uploadImage(fileName){
    console.log(fileName);
    let path = "Opportunityimages/"+fileName;
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
    address["country"] = this.state.country;
    address["housenumber"] = parseInt(this.state.house_number);
    address["latitude"] = this.state.lat;
    address["longitude"] = this.state.lng;
    address["postalcode"] = parseInt(this.state.postal_code);
    address["street"] = this.state.street;

    var self = this;

    firestore.createAddress(address).then(function(docRef) {
      console.log("Document written with ID: ", docRef.id);
      postNewOpportunity(docRef.id, self);
    }).catch(function(error) {
      console.error("Error adding document: ", error);
    });
  }

  postNewOpportunity(addressId, self){
    console.log(this.state.start_date);
    let opportunity = new Object();
    opportunity["addressId"] = addressId;
    opportunity["badgeId"] = this.state.badgeId;
    opportunity["beaconId"] = "";
    opportunity["beginDate"] = this.state.start_date;
    opportunity["authority"] = 0;
    opportunity["category"] = parseInt(this.state.category);
    opportunity["difficulty"] = parseInt(this.state.difficulty);
    opportunity["endDate"] = this.state.end_date;
    opportunity["international"] = false;
    opportunity["issuerId"] = auth.getUserId();
    opportunity["longDescription"] = this.state.description;
    opportunity["oppImageUrl"] = this.state.imageUrl;
    opportunity["pinImageUrl"] = this.state.pinImageUrl;
    opportunity["shortDescription"] = this.state.synopsis;
    opportunity["title"] = this.state.title;
    opportunity["participations"] = 0;

    firestore.createOpportunity(opportunity)
    .then(function(docRef){
      self.props.history.push(routes.AangemaakteLeerkansen);
    })
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
      pristine,
      badge,
      badges
    } = this.props

    return (
      <form onSubmit={this.handleSubmit}>
        {/* <h2>(Loop all the fields before submitting -- will be fixed soon!)</h2> */}
        {this.state.title}
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
                  value: Category[`${key}`],
                  display: key
                };
              })
            }}
            component={renderSelect}
            onChange={this.handleChange}
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
                  value: Difficulty[`${key}`],
                  display: key
                };
              })
            }}
            component={renderSelect}
            onChange={this.handleChange}
          />
        </div>
        <div className="form-group">
          <Field
            label="Start datum"
            id="start_date"
            name="start_date"
            type="date"
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
            type="date"
            component={renderInput}
            placeholder="DD/MM/JJJJ"
            value={this.state.end_date}
            onChange={ this.handleChange }
            required
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
            type="number"
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
            type="number"
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
          <button type="submit" disabled={submitting || pristine}>
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
  validate,
  // fields: ['title', 'synopsis'],
  enableReinitialize: true
  // initialValues: {
  //   title: "test"
  // }
})(FormCreateLeerkans);

export default FormCreateLeerkans;