import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

import { firestore } from './../Firebase';

class Detail extends Component {
  render() {
    const { opportunities } = this.props;
    const id = this.props.match.params.id;

    return (
      <React.Fragment>
        { !! opportunities && <LeerkansDetail opportunity={ opportunities[id] } /> }
				{ ! opportunities && <EmptyList/> }
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
      issuer: null
		};
  }
  componentDidMount() {
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
    const { address, cat, diff, issuer } = this.state;

    return (
      // <div className="card-container leerkansen">
      //   <a href="/leerkansen" className="back">&lt; Terug</a>
      //   <div className="card-item leerkans">
      //     <h1>{opportunity.title}</h1>
      //     <img src={opportunity.oppImageUrl ? `${opportunity.oppImageUrl}` : null} className="photo" alt="" />
      //     <div style={{position: "relative"}}>
      //       <img src={`${opportunity.pinImageUrl}`} className="badge" alt="" />
      //       {/* <h2>{opportunity.title}</h2> */}
            // <div className="meta-data">
            //   <small>{opportunity.beginDate + ' - ' + opportunity.endDate}</small>
            //   {!!address && <Address address={address}/>}
            //   {/* <small>{opportunity.street + ' ' + opportunity.house_number + ', ' + opportunity.postal_code + ' ' + opportunity.city}</small> */}
            // </div>
      //       <p>Categorie: {cat}, Moeilijkheidsgraad: {diff}</p>
      //       <h3>Beschrijving:</h3>
      //       <p>{opportunity.longDescription}</p>
      //       <h3>Wat wordt er verwacht?</h3>
      //       <p>{opportunity.shortDescription}</p>
      //     </div>
      //   </div>
      // </div> 
      <div class="opportunity-detail">
        <div class="overlay"></div>
        <div class="titlehead" style={{backgroundImage: `url(${opportunity.oppImageUrl})`}}>
          <div class="opportunity-container">
              <h1>{opportunity.title}</h1>
          </div>
        </div>
        {/* <a href="/leerkansen" className="back">&lt; Terug</a> */}
        <div id="page" class="opportunity-container">
          <div class="infobox">
            <h3>Info:</h3>
            <div class="infobox-content">
              <div class="content-left">
                {!!issuer && <p><b>Eigenaar van de leerkans:</b></p>}
                {!!address && <p><b>Locatie:</b></p>}
                <p><b>Periode:</b></p>
                <p><b>Aantal deelnemers:</b></p>
              </div>
              <div class="content-right">
                {!!issuer && <p>{issuer.name}</p>}
                {!!address && <p>{address.street} {address.housenumber}, {address.postalcode} {address["city"]}</p>}
                <p>{opportunity.beginDate + ' tot en met ' + opportunity.endDate}</p>
                <p>{opportunity.participations}</p>
              </div>
              {/* <div class="badge"> */}
                
              {/* </div> */}
            </div>
            <img class="badge" src={opportunity.pinImageUrl}/>
          </div>
          <br/>          
          <h3>Beschrijving</h3>
          <p>{opportunity.longDescription}</p>
          <h3>Wat wordt er verwacht?</h3>
          <p>{opportunity.shortDescription}</p>
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


export default Detail;
