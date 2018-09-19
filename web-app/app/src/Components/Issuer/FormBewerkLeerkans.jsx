import React, { Component } from 'react';
import { withRouter } from 'react-router';

import { Field, reduxForm } from 'redux-form';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput, validate } from './../Utils';

import { auth, firestore } from './../Firebase';

import { Category, Difficulty} from '../Leerkansen/Constants';

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
        imageExtension: ""
      };
    }
    componentDidUpdate() {
      if(!this.state.initialised && this.props.initValues){
        this.setState({
          initialised: true,
          address: this.props.initValues.street+" "+this.props.initValues.house_number+
          ", "+this.props.initValues.postal_code+" "+this.props.initValues.city,
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
                      {!!address && <br/>}
                      {!!address && <tr>
                        <td><b>Locatie:</b></td>
                        <td><Field
                            type="text"
                            name="address"
                            id="address"
                            component={renderInput}
                            defaultValue="Adres"
                            placeholder="Adres"
                            value={this.state.address}
                            onChange={ this.handleChange }
                        /></td>
                      </tr>}
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
              <button className="opp-edit-save" type="submit" disabled={submitting || pristine}>
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