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
	  }
    componentDidMount() {
        var res = new Object();
        var self = this;
        firestore.onceGetParticipationsForOpportunity(this.props.match.params.id).then((participations) => {
			participations.forEach(function (participation){
                let id = participation.data().participantId;
                // console.log(id);
                firestore.onceGetParticipant(id).then(participant => {
                    // console.log(participant.id);
                    // console.log(participant.data);
                    res[participant.id] = participant.data();
                    self.setState(() => ({ participants: res }))
                    // console.log({[participant.id]: participant.data()});
                })
                .catch(err => {
                    console.log('Error getting documents', err);
                });
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
        { !! participants && <ParticipantsList participants={ participants } opportunity={ opportunities[id] } />}
            { ! opportunities && <EmptyList/> }
        </React.Fragment>
      
    )
  }
}

class ParticipantsList extends Component{
    constructor(props){
        super(props);

        this.handleClick = this.handleClick.bind(this);

        this.state ={

        }
    }
    handleClick(event) {
        event.preventDefault();
        let participantId = event.target.id
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
    }
    render() {
        const { participants } = this.props;
        return(
            <div>
                <h1>DEELNEMERS:</h1>
                {Object.keys(participants).map(key =>
                    <div className='card-item participant'>
                        <div>
                            <h3>Deelnemer: {participants[key].name}</h3>
                            <small>Geboortedatum: {participants[key].birthdate}</small>
                            <small>Educatie: {participants[key].education}</small>
                            <small>Email: {participants[key].email}</small>
                            <small>Institutie: {participants[key].institute}</small>
                            <img src={participants[key].image}/>
                        </div>
                        <button onClick={this.handleClick} id={key}>Geef badge</button>
                    </div>
                )}
            </div>
        )
    }
}

const LeerkansDetail = ({ opportunity }) =>
  <div>
    <a href="/leerkansen">Back</a>
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
