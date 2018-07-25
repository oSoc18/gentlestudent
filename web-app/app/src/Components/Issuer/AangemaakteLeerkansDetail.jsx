import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

import { firestore } from './../Firebase';

class AangemaakteLeerkansDetail extends Component {
    constructor(props) {
		super(props);
	
		this.state = {
          participants: null,
        };

        this.loadParticipants = this.loadParticipants.bind(this);
	  }
    componentDidMount() {
        this.loadParticipants();
    }
    loadParticipants(){
        this.state.participants = null;
        var res = new Object();
        var self = this;
        firestore.onceGetParticipationsForOpportunity(this.props.match.params.id).then((participations) => {
			participations.forEach(function (participation){
                let participantid = participation.data().participantId;
                let status = participation.data().status;
                let participationId = participation.id;
                // console.log(id);
                // if(status!=2){
                    firestore.onceGetParticipant(participantid).then(participant => {
                        // console.log(participant.id);
                        // console.log(participant.data());
                        res[participant.participantid] = participant.data();
                        res[participant.participantid]["participationStatus"] = status;
                        res[participant.participantid]["participationId"] = participationId;
                        self.setState(() => ({ participants: res }))
                    })
                    .catch(err => {
                        console.log('Error getting documents', err);
                    });
                // }
            })
            // console.log(this.state.participants);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
    }
  render() {
    const { opportunities } = this.props;
    const { participants } = this.state;
    const id = this.props.match.params.id;

    return (
      <React.Fragment>
        { !! opportunities && <LeerkansDetail opportunity={ opportunities[id] } /> }
        { !! participants && <ParticipantsList participants={ participants } opportunity={ opportunities[id] } loadParticipants={this.loadParticipants}/>}
            { ! opportunities && <EmptyList/> }
        </React.Fragment>
      
    )
  }
}

class ParticipantsList extends Component{
    constructor(props){
        super(props);

        this.giveBadge = this.giveBadge.bind(this);
        this.accept = this.accept.bind(this);
        this.reject = this.reject.bind(this);
        this.undo = this.undo.bind(this);

        this.state ={

        }
    }
    giveBadge(event) {
        event.preventDefault();
        let participantId = event.target.id;
        let badgeId = this.props.opportunity.badgeId;
        let date = new Date();
        let today = date.getFullYear()+"-"+date.getMonth()+"-"+date.getDay();
        let assertion = new Object();
        assertion["badge"] = badgeId;
        assertion["badgeId"] = badgeId;
        assertion["id"] = "";
        assertion["issuedOn"] = today;
        assertion["recipient"] = participantId;
        assertion["recipientId"] = participantId;
        assertion["type"] = "Assertion";
        assertion["verification"] = badgeId;
        firestore.createNewAssertion(assertion);
        this.props.loadParticipants();
    }
    accept(event) {
        event.preventDefault();
        var self = this;
        firestore.acceptParticipation(event.target.id)
        .then( res =>{
            // self.props.loadParticipants();
        })
        .catch(err => {
            console.log("failed accepting participation:"+err);
        });
        self.props.loadParticipants();
    }
    reject(event) {
        event.preventDefault();
        var self = this;
        firestore.rejectParticipation(event.target.id)
        .then( res =>{
            // self.props.loadParticipants();
        })
        .catch(err => {
            console.log("failed rejecting participation:"+err);
        });  
        self.props.loadParticipants();
    }
    undo(event) {
        event.preventDefault();
        var self = this;
        firestore.undoParticipation(event.target.id)
        .then( res =>{
            // self.props.loadParticipants();
        })
        .catch(err => {
            console.log("failed rejecting participation:"+err);
        });  
        self.props.loadParticipants();
    }
    render() {
        const { participants } = this.props;
        return(
            <div>
                <h1>Deelnemers:</h1>
                {Object.keys(participants).map(key =>
                    <div className='card-item participant' key={key}>
                        <div>
                            <h3>Deelnemer: {participants[key].name}</h3>
                            <small>Geboortedatum: {participants[key].birthdate}</small>
                            <small>Educatie: {participants[key].education}</small>
                            <small>Email: {participants[key].email}</small>
                            <small>Institutie: {participants[key].institute}</small>
                            <img src={participants[key].image}/>
                        </div>
                        { participants[key]["participationStatus"]===1 && <button onClick={this.giveBadge} id={key}>Geef badge</button>}
                        { participants[key]["participationStatus"]===0 && <button onClick={this.accept} id={participants[key]["participationId"]}>Accepteer</button>}
                        { participants[key]["participationStatus"]===0 && <button onClick={this.reject} id={participants[key]["participationId"]}>Weiger</button>}
                        { participants[key]["participationStatus"]===2 && <p>Participatie geweigerd</p>}
                        { participants[key]["participationStatus"]===2 && <button onClick={this.undo} id={participants[key]["participationId"]}>Maak ongedaan</button>}
                    </div>
                )}
            </div>
        )
    }
}

const LeerkansDetail = ({ opportunity }) =>
  <div>
    <a href="/aangemaakte-leerkansen" className="back">&lt; Terug</a>
    {/* {JSON.stringify(opportunity)} */}
    <h2>{opportunity.title}</h2>
    <p>{opportunity.shortDescription}</p>
    {/* <h1>{opportunities[id].title}</h1>
    <p>{opportunities[id].description}</p> */}
  </div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>


export default AangemaakteLeerkansDetail;
