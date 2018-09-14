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
                let id = participation.data().participantId;
                let status = participation.data().status;
                let participationId = participation.id;
                // console.log(id);
                // if(status!=2){
                    firestore.onceGetParticipant(id).then(participant => {
                        // console.log(participant.id);
                        // console.log(participant.data());
                        res[participant.id] = participant.data();
                        res[participant.id]["participationStatus"] = status;
                        res[participant.id]["participationId"] = participationId;
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
        let month = ""+(date.getMonth()+1);
        if(month.length==1){
            month="0"+month;
        }
        let day = ""+(date.getDate());
        if(day.length==1){
            day="0"+month;
        }
        let today = date.getFullYear()+"-"+month+"-"+day;
        console.log(today);
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

const LeerkansDetail = ({ opportunity, issuer, address }) =>
<div class="opportunity-detail">
    <div class="overlay"></div>
    <div class="titlehead" style={{backgroundImage: `url(${opportunity.oppImageUrl})`}}>
    <div class="opportunity-container">
        <h1>{opportunity.title}</h1>
    </div>
    </div>
    <div id="page" class="opportunity-container">
    <a href="/leerkansen" className="back">&lt; Terug</a>
    <img class="badge" src={opportunity.pinImageUrl}/>
    <div class="content">
        <div class="content-left">
        <h3>Beschrijving</h3>
        <p>{opportunity.longDescription}</p>
        <h3>Wat wordt er verwacht?</h3>
        <p>{opportunity.shortDescription}</p>
        </div>
        <div class="content-right">
        <br/>
        <div class="infobox">
            <h3>Info:</h3>
            <div class="infobox-content">
            {/* <div class="content-left">
                {!!issuer && <p><b>Eigenaar:</b><br/></p>}
                {!!address && <p><b>Locatie:</b><br/></p>}
                <p><b>Periode:</b><br/></p>
                <p><b>Aantal deelnemers:</b><br/></p>
            </div>
            <div class="content-right">
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
                {!!address && <tr>
                    <td><b>Locatie:</b></td>
                    <td>{address.street} {address.housenumber}, {address.postalcode} {address["city"]}</td>
                </tr>}
                <tr>
                    <td><b>Periode:</b></td>
                    <td>{opportunity.beginDate + ' tot en met ' + opportunity.endDate}</td>
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
    </div>
    <br/>
    <br/>
</div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>


export default AangemaakteLeerkansDetail;
