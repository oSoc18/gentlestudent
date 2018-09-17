import React, { Component } from 'react';
import { withRouter } from 'react-router';

import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';

import Spinner from '../Spinner';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput, validate } from './../Utils';

import { auth, firestore } from './../Firebase';

class BewerkLeerkans extends Component {
  constructor(props){
    super(props);

    this.state={
      opportunity: null,
      id: this.props.match.params.id
    };
  }
  componentDidMount(){
    if(this.props.opportunities==undefined){
      firestore.onceGetOpportunity(this.state.id).then(doc => {
        if(doc.data() && doc.data().authority==0){
          this.setState(() => ({ opportunity: doc.data() }));
        }
        else{
          throw new Error("Opportunity does not exist or has incorrect authority.")
        }
      })
      .catch(err => {
        console.log('Could not fetch opportunity data: ', err);
        this.props.history.push("/404");
      });
    }
    else{
      this.setState(() => ({ opportunity: this.props.opportunities[this.state.id] }));
    }
  }
  render() {
    const {opportunity} = this.state;

    return (
      <React.Fragment>
        { !! opportunity && <LeerkansDetail opportunity={ opportunity }/> }
				{ ! opportunity && <EmptyList/> }
			</React.Fragment>
      
    )
  }
}

class LeerkansDetail extends Component {
  constructor(props){
    super(props);
    this.state = {
      address: null,
      cat: "",
      diff: "",
      issuer: null,
      userHasRights: false,
		};
  }
  componentDidMount() {
    let userId= auth.getUserId();
    if(userId!=""){
      if(this.props.opportunity.issuerId == userId){this.setState(() => ({ userHasRights: true }));}
      else{
        firestore.onceGetAdmin(userId).then(doc => {
          var res = new Object();
          if(doc.data()){
            this.setState(() => ({ userHasRights: true }));
          }
        })
        .catch(err => {
          console.log('User is not an admin', err);
        });
      }
    }    
    switch(this.props.opportunity.category){
      case 0: this.setState({cat: "Digitale Geletterdheid"}); break;
      case 1: this.setState({cat: "Duurzaamheid"}); break;
      case 2: this.setState({cat: "Ondernemingszin"}); break;
      case 3: this.setState({cat: "Onderzoekende houding"}); break;
      case 4: this.setState({cat: "Wereldburgerschap"}); break;
    }
    switch(this.props.opportunity.difficulty){
      case 0: this.setState({diff: "Beginner"}); break;
      case 1: this.setState({diff: "Intermediate"}); break;
      case 2: this.setState({diff: "Expert"}); break;
    }
    firestore.onceGetAddress(this.props.opportunity.addressId).then(snapshot => {
      // console.log(JSON.stringify(snapshot.data()));
			this.setState(() => ({ address: snapshot.data() }));
		})
		.catch(err => {
			console.log('Error getting documents', err);
    });
    firestore.onceGetIssuer(this.props.opportunity.issuerId).then(snapshot => {
      // console.log(JSON.stringify(snapshot.data()));
			this.setState(() => ({ issuer: snapshot.data() }));
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
  }
  render() {
    const { opportunity } = this.props;
    const { address, issuer } = this.state;

    return (
      <div className="opportunity-detail">
        {/* {!!opportunity.authority==0 && 
          <div className="opportunity-page-warning">
            <p><i className="fas fa-exclamation"></i> Dit is een preview van hoe de detailpagina van jouw leerkans er zal uitzien. 
              Andere gebruikers zullen deze pagina pas kunnen zien wanneer de leerkans goedgekeurd is.</p>
          </div>
        } */}
        <div className="overlay"></div>
        <div className="titlehead" style={{backgroundImage: `url(${opportunity.oppImageUrl})`}}>
          <div className="opportunity-container">
              <h1>{opportunity.title}</h1>
          </div>
        </div>
        <div id="page" className="opportunity-container">
          {/* <a href="/leerkansen" className="back">&lt; Terug</a> */}
          <img className="badge" src={opportunity.pinImageUrl}/>
          <FormBewerkLeerkans opportunity={opportunity} address={address} issuer={issuer}/>
          {/* {!!userHasRights && <List opportunity={ opportunity } id={ id }/>} */}
        </div>
        <br/>
        <br/>
      </div>
    )
  }
}

class FormBewerkLeerkans extends Component{
  constructor(props){
    super(props);

    this.state={
      title: ""
    }
  }
  render() {
    const { opportunity, address, issuer, submitting, pristine } = this.props;

    return (
      <React.Fragment>
        <form onSubmit={this.handleSubmit}>
          <div className="content content-flex">
            <div className="content-left">
              <div className="form-group">
                <Field
                  type="text"
                  name="title"
                  id="title"
                  info="Schrijf hier een motiverende en uitdagende titel voor jouw leerkans"
                  component={renderInput}
                  defaultValue="Titel"
                  placeholder="Titel"
                  value={this.state.title}
                  onChange={ this.handleChange }
                />
              </div>
              <h3>Beschrijving</h3>
              <p>{opportunity.longDescription}</p>
              <h3>Wat wordt er verwacht?</h3>
              <p>{opportunity.shortDescription}</p>
              <h3>Meer weten?</h3>
              <p> <a href={opportunity.moreInfo}>Klik hier</a> om meer te weten.</p>
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
                      <td>{opportunity.website}</td>
                    </tr>
                    <tr>
                      <td><b>Contact:</b></td>
                      <td>{opportunity.contact}</td>
                    </tr>
                    {!!address && <br/>}
                    {!!address && <tr>
                      <td><b>Locatie:</b></td>
                      <td>{address.street} {address.housenumber}, {address.postalcode} {address["city"]}</td>
                    </tr>}
                    <tr>
                      <td><b>Periode:</b></td>
                      <td>{opportunity.beginDate + ' tot en met ' + opportunity.endDate}</td>
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
            <button type="submit" disabled={submitting || pristine}>
              Bewaar
            </button>
          </div>
        </form>
      </React.Fragment>
    )
  }
}

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

BewerkLeerkans = reduxForm({
  form: 'BewerkLeerkans',
  validate,
  // fields: ['title', 'synopsis'],
  enableReinitialize: true
  // initialValues: {
  //   title: "test"
  // }
})(BewerkLeerkans);

export default withRouter(BewerkLeerkans);
