import React, { Component } from 'react';
import { withRouter } from 'react-router';

import { connect } from 'react-redux';

import Spinner from '../../../Shared/Spinner';

import FormBewerkLeerkans from './FormBewerkLeerkans';

import { auth, firestore } from '../../../Utils/Firebase';

class BewerkLeerkans extends Component {
  constructor(props){
    super(props);

    this.state={
      opportunity: null,
      id: this.props.match.params.id,
      initValues: {}
    };
  }
  componentDidMount(){
    var self = this;
    if(this.props.opportunities==undefined){
      firestore.onceGetOpportunity(this.state.id).then(doc => {
        if(doc.data() && doc.data().authority==0){
          this.setState(() => ({ opportunity: doc.data() }));
          var start_date = doc.data().beginDate;
          // var category= self.getEnumValue(Category, doc.data().category);
          var category = doc.data().category;
          // var difficulty= self.getEnumValue(Difficulty, doc.data().difficulty);
          var difficulty = doc.data().difficulty;
          var end_date = doc.data().endDate;
          var description = doc.data().longDescription;
          var oppImageUrl = doc.data().oppImageUrl;
          var synopsis = doc.data().shortDescription;
          var title = doc.data().title;
          var moreInfo = doc.data().moreInfo;
          var website = doc.data().website;
          var contact = doc.data().contact
          firestore.onceGetAddress(doc.data().addressId).then(snapshot => {
            self.setState({
              initValues: {
                address: snapshot.data().street+" "+snapshot.data().housenumber+
                ", "+snapshot.data().postalcode+" "+snapshot.data().city,
                start_date: start_date,
                category: category,
                city: snapshot.data().city,
                country: snapshot.data().country,
                difficulty: difficulty,
                end_date: end_date,
                description: description,
                house_number: snapshot.data().housenumber,
                latitude: snapshot.data().latitude,
                longitude: snapshot.data().longitude,
                oppImageUrl: oppImageUrl,
                postal_code: snapshot.data().postalcode,
                street: snapshot.data().street,
                synopsis: synopsis,
                title: title,
                moreInfo: moreInfo,
                website: website,
                contact: contact
              }
            });
          }).catch(function(error) {
            console.error("Error getting document: ", error);
          });
        }
        else{
          throw new Error("Opportunity does not exist, has incorrect data or has elevated authority.")
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
    const {opportunity, initValues} = this.state;

    return (
      <React.Fragment>
        { !! opportunity && <LeerkansDetail history={this.props.history} opportunity={ opportunity } id={this.props.match.params.id} initValues={ initValues } /> }
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
    const { opportunity, initValues, id } = this.props;
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
        <div className="titlehead-wrapper" style={{backgroundImage: `url(${opportunity.oppImageUrl})`}}>
          <div className="titlehead">
            <div className="opportunity-container">
                <h1>Bewerk leerkans: {opportunity.title}</h1>
            </div>
          </div>
        </div>
        <div id="page" className="opportunity-container">
          {/* <a href="/leerkansen" className="back">&lt; Terug</a> */}
          <img className="badge" src={opportunity.pinImageUrl}/>
          <FormBewerkLeerkans history={this.props.history} opportunity={opportunity} id={id} address={address} issuer={issuer} initialValues={ initValues} initValues={ initValues} />
          {/* {!!userHasRights && <List opportunity={ opportunity } id={ id }/>} */}
        </div>
        <br/>
        <br/>
      </div>
    )
  }
}

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

export default withRouter(BewerkLeerkans);
