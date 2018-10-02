import React, { Component } from 'react';
import { withRouter } from 'react-router';
import Geocode from "react-geocode";

import { Field, reduxForm } from 'redux-form';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput, validate } from './../Utils';

import { auth, firestore } from './../Firebase';
import firebase from 'firebase';
import 'firebase/storage';

import { Category, Difficulty} from '../Leerkansen/Constants';

import * as routes from '../../routes/routes';

// set Google Maps Geocoding API for purposes of quota management. Its optional but recommended.
Geocode.setApiKey(process.env.REACT_APP_GOOGLE_MAPS_API_KEY);

/* Default position */
var defaultPosition = {
  lat: 51.0511164,
  lng: 3.7114566
};

class FormBewerkLeerkans extends Component{
    constructor(props){
      super(props);
  
      this.state = {
        initialised: false,
        lat: 51.0511164,
        lng: 3.7114566,
        address: "",
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
        title: "",
        moreInfo: "",
        website: "",
        contact: "",
        image: "",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunityimages%2FNederlandse%20Les.jpg?alt=media&token=82cecaa7-4d6e-473d-b06a-a5eea35d8d4b",
        imageExtension: "",
        pinImageUrl: ""
      };

      this.handleChange = this.handleChange.bind(this);
      this.handleImage = this.handleImage.bind(this);
      this.handleSubmit = this.handleSubmit.bind(this);
      this.uploadImage = this.uploadImage.bind(this);
      this.choosePin = this.choosePin.bind(this);
      this.changeAddress = this.changeAddress.bind(this);
    }
    componentDidUpdate() {
      if(!this.state.initialised && this.props.initValues && Object.keys(this.props.initValues).length>0){
        console.log("initialising state");
        this.setState({
          initialised: true,
          start_date: this.props.initValues.start_date,
          category: this.props.initValues.category,
          city: this.props.initValues.city,
          country: this.props.initValues.country,
          difficulty: this.props.initValues.difficulty,
          end_date: this.props.initValues.end_date,
          description: this.props.initValues.description,
          house_number: this.props.initValues.house_number,
          lat: this.props.initValues.latitude,
          lng: this.props.initValues.longitude,
          oppImageUrl: this.props.initValues.oppImageUrl,
          postal_code: this.props.initValues.postal_code,
          street: this.props.initValues.street,
          synopsis: this.props.initValues.synopsis,
          title: this.props.initValues.title,
          moreInfo: this.props.initValues.moreInfo,
          website: this.props.initValues.website,
          contact: this.props.initValues.contact
        });
      }
    }
    getEnumValue(enumTable, i){
      var keys = Object.keys(enumTable).sort(function(a, b){
        return enumTable[a] - enumTable[b];
      }); //sorting is required since the order of keys is not guaranteed.
      
      var getEnum = function(ordinal) {
        return keys[ordinal];
      }
  
      return getEnum(i);
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
      this.state.pinImageUrl= url;
    }
    handleChange(event) {
      this.setState({[event.target.id]: event.target.value});
      if(event.target.id=="street" 
        || "house_number" 
        || "city" 
        || "postal_code" 
        || "country" ){
          this.changeAddress();
        }
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
    handleImage(event) {
      this.setState({image: event.target.files[0]});
      this.setState({imageExtension: event.target.value.split('.').pop()});
    }
    checkDate(s){
      if(/^([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$/.test(s)){
        return s;
      }
      let day = s.split("-")[0];
      let month = s.split("-")[1];
      let year = s.split("-")[2];
      return year+"-"+month+"-"+day;
    }
    handleSubmit(event) {
      event.preventDefault();
      if(this.state.image != ""){
        let fileName = this.state.title+"."+this.state.imageExtension;
        let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Opportunityimages%2F";
        this.setState({imageUrl: baseUrl + encodeURIComponent(fileName)+"?alt=media"});
        this.uploadImage(fileName);
      }
      if(this.state.street != this.props.initValues.street){
        firestore.updateAddress(this.props.opportunity.addressId, "street", this.state.street).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.house_number != this.props.initValues.house_number){
        firestore.updateAddress(this.props.opportunity.addressId, "housenumber", this.state.house_number).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.postal_code != this.props.initValues.postal_code){
        firestore.updateAddress(this.props.opportunity.addressId, "postalcode", this.state.postal_code).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.city != this.props.initValues.city){
        firestore.updateAddress(this.props.opportunity.addressId, "city", this.state.city).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.country != this.props.initValues.country){
        firestore.updateAddress(this.props.opportunity.addressId, "country", this.state.country).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.lat != this.props.initValues.lat){
        firestore.updateAddress(this.props.opportunity.addressId, "latitude", this.state.lat).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.lng != this.props.initValues.lng){
        firestore.updateAddress(this.props.opportunity.addressId, "longitude", this.state.lng).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating address: ", error);
        });
      }
      if(this.state.start_date != this.props.initValues.start_date){
        firestore.updateOpportunity(this.props.id, "beginDate", this.state.start_date).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field beginDate: ", error);
        });
      }
      if(this.state.category !=this.props.initValues.category){
        firestore.updateOpportunity(this.props.id, "category", parseInt(this.state.category)).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field category: ", error);
        });
        this.choosePin();
      }
      if(this.state.difficulty != this.props.initValues.difficulty){
        firestore.updateOpportunity(this.props.id, "difficulty", parseInt(this.state.difficulty)).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field difficulty: ", error);
        });
        this.choosePin();
      }
      if(this.state.end_date != this.props.initValues.end_date){
        firestore.updateOpportunity(this.props.id, "endDate", this.state.end_date).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field endDate: ", error);
        });
      }
      if(this.state.description != this.props.initValues.description){
        firestore.updateOpportunity(this.props.id, "longDescription", this.state.description).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field longdescription: ", error);
        });
      }
      if(this.state.oppImageUrl != this.props.initValues.oppImageUrl){
        firestore.updateOpportunity(this.props.id, "oppImageUrl", this.state.imageUrl).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field oppImageUrl: ", error);
        });
      }
      if(this.state.pinImageUrl != this.props.initValues.pinImageUrl && this.state.pinImageUrl != ""){
        firestore.updateOpportunity(this.props.id, "pinImageUrl", this.state.pinImageUrl).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field pinImageUrl: ", error);
        });
      }
      if(this.state.synopsis != this.props.initValues.synopsis){
        firestore.updateOpportunity(this.props.id, "shortDescription", this.state.synopsis).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field shortDescription: ", error);
        });
      }
      if(this.state.title != this.props.initValues.title){
        firestore.updateOpportunity(this.props.id, "title", this.state.title).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field title: ", error);
        });
      }
      if(this.state.moreInfo != this.props.initValues.moreInfo){
        firestore.updateOpportunity(this.props.id, "moreInfo", this.state.moreInfo).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field moreInfo: ", error);
        });
      }
      if(this.state.website != this.props.initValues.website){
        firestore.updateOpportunity(this.props.id, "website", this.state.website).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field website: ", error);
        });
      }
      if(this.state.contact != this.props.initValues.contact){
        firestore.updateOpportunity(this.props.id, "contact", this.state.contact).then(function(snapshot) {
        }).catch(function(error) {
          console.error("Error updating field contact: ", error);
        });
      }
      this.props.history.push(routes.Leerkansen+'/'+this.props.id);
    }
    render() {
      const { opportunity, address, issuer, submitting, pristine } = this.props;
  
      return (
        <React.Fragment>
          <form onSubmit={this.handleSubmit}>
            {/* <div className="form-group">
              <button className="opp-detail-option" type="submit" disabled={submitting || pristine}>
                Bewaar
              </button>
            </div> */}
            <div className="content content-flex">
              <div className="content-left">
                <div className="form-group">
                    <h3>Type leerkans</h3>
                    <Field
                        id="category"
                        name="category"
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
                    {/* <h3>Niveau</h3> */}
                    <Field
                        id="difficulty"
                        name="difficulty"
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
                  <h3>Titel</h3>
                  <Field
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
                  <h3>Beschrijving</h3>
                  <Field
                    id="description"
                    name="description"
                    component={renderTextarea}
                    placeholder="Volledige beschrijving van de leerkans"
                    value={this.state.description}
                    onChange={ this.handleChange }
                  />
                </div>
                <div className="form-group">
                    <h3>Wat wordt er verwacht?</h3>
                    <Field
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
                    <h3>Meer weten?</h3>
                    <Field
                        type="text"
                        name="moreInfo"
                        id="moreInfo"
                        component={renderInput}
                        defaultValue="Meer info"
                        placeholder="Meer info"
                        value={this.state.moreInfo}
                        onChange={ this.handleChange }
                    />
                </div>
                <div className="form-group">
                    <h3>Afbeelding vervangen</h3>
                    <input 
                        type="file"
                        label="Afbeelding uploaden"
                        className="input"
                        id="image"
                        onChange={ this.handleImage } 
                    />
                </div>
              </div>
              <div className="content-right">
                <br/>
                <div className="infobox">
                  <h3>Info:</h3>
                  <div className="infobox-content">
                    {/* <div className="content-left">
                      {!!issuer && <p><b>Eigenaar:</b><br/></p>}
                      {!!address && <p><b>Locatie:</b><br/></p>}
                      <p><b>Periode:</b><br/></p>
                      <p><b>Aantal deelnemers:</b><br/></p>
                    </div>
                    <div className="content-right">
                      {!!issuer && <p>{issuer.name}<br/></p>}
                      {!!address && <p>{address.street} {address.housenumber}, {address.postalcode} {address["city"]}<br/></p>}
                      <p>{opportunity.beginDate + ' tot en met ' + opportunity.endDate}<br/></p>
                      <p>{opportunity.participations}<br/></p>
                    </div> */}
                    <table>
                      {!!issuer && <tr>
                        <td><b>Eigenaar:</b></td>
                        <td>{issuer.name}</td>
                      </tr>}
                      <tr>
                        <td><b>Website:</b></td>
                        <td><Field
                            type="text"
                            name="website"
                            id="website"
                            component={renderInput}
                            defaultValue="Website"
                            placeholder="Website"
                            value={this.state.website}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Contact:</b></td>
                        <td><Field
                            type="text"
                            name="contact"
                            id="contact"
                            component={renderInput}
                            defaultValue="E-mailadres contactpersoon"
                            placeholder="E-mailadres contactpersoon"
                            value={this.state.contact}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <br/>
                      <tr>
                        <td><b>Straat:</b></td>
                        <td><Field
                            type="text"
                            name="street"
                            id="street"
                            component={renderInput}
                            defaultValue="Rooigemlaan"
                            placeholder="Straatnaam"
                            value={this.state.street}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Huisnummer:</b></td>
                        <td><Field
                            type="text"
                            name="house_number"
                            id="house_number"
                            component={renderInput}
                            defaultValue="123"
                            placeholder="Huisnummer"
                            value={this.state.house_number}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Post code:</b></td>
                        <td><Field
                            type="text"
                            name="postal_code"
                            id="postal_code"
                            component={renderInput}
                            defaultValue="9000"
                            placeholder="Post code"
                            value={this.state.postal_code}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Land:</b></td>
                        <td><Field
                            type="text"
                            name="country"
                            id="country"
                            component={renderInput}
                            defaultValue="Belgie"
                            placeholder="Land"
                            value={this.state.country}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Start datum:</b></td>
                        <td><Field
                            id="start_date"
                            name="start_date"
                            type="date"
                            defaultValue="01/03/2018"
                            component={renderInput}
                            placeholder="DD/MM/JJJJ"
                            value={this.state.start_date}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>
                      <tr>
                        <td><b>Eind datum:</b></td>
                        <td><Field
                            id="end_date"
                            name="end_date"
                            defaultValue="01/06/2018"
                            type="date"
                            component={renderInput}
                            placeholder="DD/MM/JJJJ"
                            value={this.state.end_date}
                            onChange={ this.handleChange }
                            required
                        /></td>
                      </tr>
                      <br/>
                      <tr>
                        <td><b>Status:</b></td>
                        {!!opportunity.authority==0 && <td>In afwachting</td>}
                        {!!opportunity.authority==1 && <td>Goedgekeurd</td>}
                        {!!opportunity.authority==2 && <td>Verwijderd</td>}
                      </tr>
                      <tr>
                        <td><b>Aantal deelnemers:</b></td>
                        <td>{opportunity.participations}</td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <br/>
            <div className="form-group">
              <button className="opp-save" type="submit" disabled={submitting || pristine}>
                Bewaar
              </button>
            </div>
          </form>
        </React.Fragment>
      )
    }
  }

  FormBewerkLeerkans = reduxForm({
    form: 'FormBewerkLeerkans',
    validate,
    // fields: ['title', 'synopsis'],
    enableReinitialize: true
    // initialValues: {
    //   title: "test"
    // }
  })(FormBewerkLeerkans);

  export default FormBewerkLeerkans;