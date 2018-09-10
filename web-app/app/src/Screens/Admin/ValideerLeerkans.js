import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import { firestore } from './../../Components/Firebase';

import Spinner from './../../Components/Spinner';
import { Field, reduxForm } from 'redux-form';

import { renderInput, renderAutomaticInput, renderTextarea, renderSelect, RenderDropzoneInput, validate } from '../../Components/Utils';

class ValideerLeerkans extends Component {
  constructor() {
    super();
    // this.submit = this.submit.bind(this);
    this.state = {
          opportunities: null,
          beacons: null
        };
        this.getOpportunities = this.getOpportunities.bind(this);
    };

    componentDidMount() {
        this.getOpportunities();
        this.getBeacons();
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
    getBeacons() {
        firestore.onceGetBeacons().then(snapshot => {
            var res = new Object();
            snapshot.forEach(doc => {
                // console.log("id:"+doc.data().beaconId);
                if(doc.data().major!==undefined && doc.data().minor!==undefined && doc.data().name!==undefined){
                    res[doc.id] = doc.data();
                }
            });
            res["MakeNew"] = {name: "> Maak een nieuwe beacon", beaconId: "MakeNewTrue"};
            this.setState(() => ({ beacons: res }))
        })
        .catch(err => {
            console.log('Error getting documents', err);
        });
    }
  render() {
    const { opportunities, beacons, getOpportunities } = this.state;

    return (
        <React.Fragment>
            { !! opportunities && !!beacons && <OpportunitiesList opportunities={ opportunities } getOpportunities={ this.getOpportunities } beacons={ beacons }/> }
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

        // this.handleClick = this.handleClick.bind(this);
        // this.postNewBadge = this.postNewBadge.bind(this);
      };
    
    //   handleClick(event) {
    //     event.preventDefault();
    //     console.log(event.target.id);
    //     firestore.validateOpportunity(event.target.id);
    //     this.postNewBadge(event.target.id);
    //     this.props.getOpportunities();
    //   }

    //   postNewBadge(opportunityId){
    //     let opportunity = this.props.opportunities[opportunityId];
    //     let badge = new Object();
    //     let name = "";
    //     let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Badges%2F";
    //     let image = baseUrl;
    //     switch(opportunity.category){
    //         case 0: {name = "Digitale Geletterdheid"; image += "badge_digitale-geletterdheid";}
    //         case 1: {name = "Duurzaamheid"; image += "badge_duurzaamheid";}
    //         case 2: {name = "Ondernemingszin"; image += "badge_ondernemingszin";}
    //         case 3: {name = "Onderzoekende houding"; image += "badge_onderzoekende-houding";}
    //         case 4: {name = "Wereldburgerschap"; image += "badge_wereldburgerschap";}
    //     }
    //     switch(opportunity.difficulty){
    //         case 0: image+= "_1.png?alt=media";
    //         case 1: image+= "_2.png?alt=media";
    //         case 2: image+= "_3.png?alt=media";
    //     }
    //     badge["type"]= "BadgeClass";
    //     badge["name"]= name;
    //     badge["description"]= opportunity.description;
    //     badge["image"]= image;
    //     badge["criteria"]= opportunity.shortDescription;
    //     badge["issuerId"]= opportunity.issuerId;
    //     firestore.createNewBadge(badge).then(function(docRef) {
    //         console.log("Document written with ID: ", docRef.id);
    //         firestore.linkBadgeToOpportunity(opportunityId, docRef.id);
    //       }).catch(function(error) {
    //         console.error("Error adding document: ", error);
    //       });
    // }

      render() {
        const { opportunities, beacons, getOpportunities } = this.props;
    
        return (
            <React.Fragment>
                <div className="container">
                    <div className="content">
                        <Link to="/" className="back">&lt; Terug</Link>
                        <h1>Valideer leerkans</h1>
                        <div className="card-container opportunities">
                            {Object.keys(opportunities).map(key =>
                                <Opportunity opportunity={opportunities[key]} key={key} id={key} getOpportunities={ getOpportunities } beacons={ beacons }/>
                            )}
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

const byPropKey = (propertyName, value) => () => ({
    [propertyName]: value,
  });

class Opportunity extends Component{
    constructor(props){
        super(props);

        this.state = {beaconId: "", makeNew: false};

        this.onSubmit = this.onSubmit.bind(this);
        this.handleChange = this.handleChange.bind(this);
        this.postNewBadge = this.postNewBadge.bind(this);
        this.validateOpportunity = this.validateOpportunity.bind(this);
        this.postNewBeacon = this.postNewBeacon.bind(this);
      };

      handleChange(event) {
        // console.log(event.target.value);
        this.setState({[event.target.id]: event.target.value});
        if(event.target.value=="MakeNewTrue"){
            this.state.makeNew = true;
        }
        else{
            this.state.makeNew = false;
        }
      }
    
      onSubmit(event) {
        event.preventDefault();
        const {beaconId} = this.state;
        this.validateOpportunity(beaconId);
      }

      validateOpportunity(beaconId){
        let opportunityId = this.props.id;
        firestore.validateOpportunity(opportunityId).catch(function(error) {
            console.error("Error validating opportunity: ", error);
          });
        console.log(beaconId);
        firestore.linkBeaconToOpportunity(opportunityId, beaconId).catch(function(error) {
            console.error("Error linking beacon: ", error);
          });
        firestore.linkOpportunityToBeacon(beaconId, opportunityId).catch(function(error) {
            console.error("Error linking opportunity: ", error);
          });
        // let data = new Object();
        // data["opportunityId"] = opportunityId;
        // firestore.createNewBeacon(beaconId, data);
        this.postNewBadge(opportunityId);
        this.props.getOpportunities();
      }

      postNewBeacon(major, minor, name){
        let addressId = this.props.opportunity.addressId;
        let beacon = new Object();
        beacon["major"] = major;
        beacon["minor"] = minor;
        beacon["range"] = 0;
        beacon["addressId"] = addressId;
        beacon["opportunities"] = {};
        beacon["name"] = name;
        let self = this;
        firestore.createNewBeacon(beacon).then(function(docRef) {
            console.log("Document written with ID: ", docRef.id);
            self.validateOpportunity(docRef.id);
          }).catch(function(error) {
            console.log("Error adding document: ", error);
          });
      }

      postNewBadge(opportunityId){
        let opportunity = this.props.opportunity;
        let badge = new Object();
        let name = "";
        let baseUrl = "https://firebasestorage.googleapis.com/v0/b/gentle-student.appspot.com/o/Badges%2F";
        let image = baseUrl;
        console.log(opportunity.category);
        console.log(opportunity.difficulty);
        switch(opportunity.category){
            case 0: name = "Digitale Geletterdheid"; image += "badge_digitale-geletterdheid"; break;
            case 1: name = "Duurzaamheid"; image += "badge_duurzaamheid"; break;
            case 2: name = "Ondernemingszin"; image += "badge_ondernemingszin"; break;
            case 3: name = "Onderzoekende houding"; image += "badge_onderzoekende-houding"; break;
            case 4: name = "Wereldburgerschap"; image += "badge_wereldburgerschap"; break;
        }
        switch(opportunity.difficulty){
            case 0: image+= "_1.png?alt=media"; break;
            case 1: image+= "_2.png?alt=media"; break;
            case 2: image+= "_3.png?alt=media"; break;
        }
        badge["type"]= "BadgeClass";
        badge["name"]= name;
        badge["description"]= opportunity.longDescription;
        badge["image"]= image;
        badge["criteria"]= opportunity.shortDescription;
        badge["issuerId"]= opportunity.issuerId;
        console.log(JSON.stringify(badge));
        firestore.createNewBadge(badge).then(function(docRef) {
            console.log("Document written with ID: ", docRef.id);
            firestore.linkBadgeToOpportunity(opportunityId, docRef.id);
          }).catch(function(error) {
            console.log("Error adding document: ", error);
          });
    }
    render () {
        const { opportunity, beacons, id } = this.props;
        const { beaconId, makeNew, error, validateOpportunity, postNewBeacon } = this.state;
        const isInvalid =
            beaconId === ""
            ;

        return(
            <div className={`card-item leerkans ${ opportunity.category }`} key={opportunity.addressId}>
                {/* <img src={opportunity.oppImageUrl ? `${opportunity.pinImageUrl}` : null} className="photo" alt={opportunity.title} /> */}
                <div style={{position: "relative"}}>
                    {/* <img src={opportunity.oppImageUrl ? `${opportunity.oppImageUrl}` : null} className="badge" /> */}
                    <h2>{opportunity.title}</h2>
                    <div className="meta-data">
                        <small>{opportunity.beginDate + ' - ' + opportunity.endDate}</small>
                        {/* <small>{opportunity.street + ' ' + opportunity.house_number + ', ' + opportunity.postal_code + ' ' + opportunity.city}</small> */}
                    </div>
                    <p>{opportunity.shortDescription}</p>
                    <form onSubmit={this.onSubmit}>
                        <div className="form-group">
                            <Field
                                id="beaconId"
                                name="beaconId"
                                label="Kies een beacon: "
                                data={{
                                list: Object.keys(beacons).map(key => {
                                    return {
                                    value: beacons[key].beaconId,
                                    display: beacons[key].name
                                    };
                                })
                                }}
                                component={renderSelect}
                                onChange={this.handleChange}
                            />
                            {!makeNew && <small>(Of maak een nieuwe beacon door de optie "> Maak een nieuwe beacon" te selecteren)</small>}
                        </div>
                        {!makeNew && <button disabled={isInvalid} type="submit">
                            Accepteren
                        </button>}

                        { error && <p>{error.message}</p> }
                    </form>
                    {!!makeNew && <AddBeacon postNewBeacon={ this.postNewBeacon }/>}
                </div>
            </div>
        )
    }
}

class AddBeacon extends Component{
    constructor(props){
        super(props);

        this.state = {major: "", minor: "", name: ""};

        this.onSubmit = this.onSubmit.bind(this);
        this.handleChange = this.handleChange.bind(this);
        // this.postNewBeacon = this.postNewBeacon.bind(this);
    }

    handleChange(event) {
        // console.log(event.target.value);
        this.setState({[event.target.id]: event.target.value});
      }
    
    onSubmit(event) {
        event.preventDefault();
        this.props.postNewBeacon(this.state.major, this.state.minor, this.state.name);
      }

    render () {
        const { opportunity, beacons, id } = this.props;
        const { major, minor, name, error } = this.state;
        const isInvalid =
            major === "" ||
            minor === "" ||
            name === ""
            ;

        return(
            <div>
                <form onSubmit={this.onSubmit}>
                    <div className="form-group">
                        Major: 
                        <input
                            value={major}
                            onChange={event => this.setState(byPropKey('major', event.target.value))}
                            type="text"
                            placeholder="Major"
                        />
                    </div>
                    <div className="form-group">
                        Minor: 
                        <input
                            value={minor}
                            onChange={event => this.setState(byPropKey('minor', event.target.value))}
                            type="text"
                            placeholder="Minor"
                        />
                    </div>
                    <div className="form-group">
                        Beacon naam:
                        <input
                            value={name}
                            onChange={event => this.setState(byPropKey('name', event.target.value))}
                            type="text"
                            placeholder="Beacon naam"
                        />
                    </div>
                    <button disabled={isInvalid} type="submit">
                        Voeg toe
                    </button>

                    { error && <p>{error.message}</p> }
                </form>
            </div>
        )
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

Opportunity = reduxForm({
    form: 'opportunity',
    validate,
    fields: ['beaconId']
  })(Opportunity);

export default ValideerLeerkans;
