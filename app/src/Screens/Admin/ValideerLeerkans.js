import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import { firestore } from './../../Components/Firebase';

import Spinner from './../../Components/Spinner';

class ValideerLeerkans extends Component {
  constructor() {
    super();
    // this.submit = this.submit.bind(this);
    this.state = {
		  opportunities: null,
        };
        this.getOpportunities = this.getOpportunities.bind(this);
    };

    componentDidMount() {
        this.getOpportunities();
    }
    getOpportunities() {
        firestore.onceGetNonValidatedOpportunities().then(snapshot => {
            var res = new Object();
            snapshot.forEach(doc => {
                res[doc.id] = doc.data();
            });
            this.setState(() => ({ opportunities: res }))
        })
        .catch(err => {
            console.log('Error getting documents', err);
        });
    }
  render() {
    const { opportunities, getOpportunities } = this.state;

    return (
        <React.Fragment>
            { !! opportunities && <OpportunitiesList opportunities={ opportunities } getOpportunities={ this.getOpportunities } /> }
            { !! opportunities && Object.getOwnPropertyNames(opportunities).length === 0 && <EmptyList/> }
            { ! opportunities && <Loading/> }
        </React.Fragment>
    );
  }
}

class OpportunitiesList extends Component{
    constructor(props) {
        super(props);

        this.state = {};

        this.handleClick = this.handleClick.bind(this);
        this.postNewBadge = this.postNewBadge.bind(this);
      };
    
      handleClick(event) {
        event.preventDefault();
        console.log(event.target.id);
        firestore.validateOpportunity(event.target.id);
        this.postNewBadge(event.target.id);
        this.props.getOpportunities();
      }

      postNewBadge(opportunityId){
        let opportunity = this.props.opportunities[opportunityId];
        let badge = new Object();
        let name = "";
        let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Badges%2F";
        let image = baseUrl;
        switch(opportunity.category){
            case 0: {name = "Digitale Geletterdheid"; image += "badge_digitale-geletterdheid";}
            case 1: {name = "Duurzaamheid"; image += "badge_duurzaamheid";}
            case 2: {name = "Ondernemingszin"; image += "badge_ondernemingszin";}
            case 3: {name = "Onderzoekende houding"; image += "badge_onderzoekende-houding";}
            case 4: {name = "Wereldburgerschap"; image += "badge_wereldburgerschap";}
        }
        switch(opportunity.difficulty){
            case 0: image+= "_1.png?alt=media";
            case 1: image+= "_2.png?alt=media";
            case 2: image+= "_3.png?alt=media";
        }
        badge["type"]= "BadgeClass";
        badge["name"]= name;
        badge["description"]= opportunity.description;
        badge["image"]= image;
        badge["criteria"]= opportunity.shortDescription;
        badge["issuerId"]= opportunity.issuerId;
        firestore.createBadge(badge).then(function(docRef) {
            console.log("Document written with ID: ", docRef.id);
            firestore.linkBadgeToOpportunity(opportunityId, docRef.id);
          }).catch(function(error) {
            console.error("Error adding document: ", error);
          });
    }

      render() {
        const { opportunities } = this.props;
    
        return (
            <React.Fragment>
                <div className="container">
                    <div className="content">
                        <Link to="/">Back</Link>
                        <h1>Valideer leerkans</h1>
                        <div className="card-container opportunities">
                            {Object.keys(opportunities).map(key =>
                                <div className={`card-item leerkans ${ opportunities[key].category }`} key={opportunities[key].addressId}>
                                    <img src={opportunities[key].oppImageUrl ? `https://gentlestudent-api.herokuapp.com/leerkansen/${opportunities[key].pinImageUrl}` : null} className="photo" alt={opportunities[key].title} />
                                    <div style={{position: "relative"}}>
                                    <img src={`https://api.badgr.io/public/badges/${opportunities[key].pinImageUrl}/image",`} className="badge" alt={opportunities[key].category + opportunities[key].difficulty} />
                                    <h2>{opportunities[key].title}</h2>
                                    <div className="meta-data">
                                    <small>{opportunities[key].beginDate + ' - ' + opportunities[key].endDate}</small>
                                    {/* <small>{opportunities[key].street + ' ' + opportunities[key].house_number + ', ' + opportunities[key].postal_code + ' ' + opportunities[key].city}</small> */}
                                    </div>
                                    <p>{opportunities[key].shortDescription}</p>
                                    <button onClick={this.handleClick} id={key}>Accepteren</button>
                                    </div>
                                </div>
                            )}
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}
    

const EmptyList = () =>
    <div>
        <div className="container">
            <div className="content">
                Er zijn geen te valideren leerkansen.
            </div>
        </div>
    </div>

const Loading = () =>
	<div>
		<Spinner />
	</div>

export default ValideerLeerkans;
