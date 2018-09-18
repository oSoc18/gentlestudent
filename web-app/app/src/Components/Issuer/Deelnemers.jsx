import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

import { firestore } from './../Firebase';

class List extends Component {
	constructor(props){
        super(props);

        this.giveBadge = this.giveBadge.bind(this);
        this.accept = this.accept.bind(this);
        this.reject = this.reject.bind(this);
        this.undo = this.undo.bind(this);

        this.state ={
			participants: null
        }
	}
	componentDidMount(){
		this.loadParticipants();
	}
	loadParticipants(){
        var res = new Object();
		var self = this;
		console.log("fetching participations for opportunity with id "+this.props.id);
        firestore.onceGetParticipationsForOpportunity(this.props.id).then((participations) => {
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
            console.log(this.state.participants);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
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
		var self = this;
        firestore.completeParticipation(event.target.id)
			.then( res =>{
				self.loadParticipants();
			})
			.catch(err => {
				console.log("failed accepting participation:"+err);
			});
        // this.loadParticipants();
    }
    accept(event) {
        event.preventDefault();
        var self = this;
        firestore.acceptParticipation(event.target.id)
        .then( res =>{
            self.loadParticipants();
        })
        .catch(err => {
            console.log("failed accepting participation:"+err);
        });
        // self.loadParticipants();
    }
    reject(event) {
        event.preventDefault();
        var self = this;
        firestore.rejectParticipation(event.target.id)
        .then( res =>{
            self.loadParticipants();
        })
        .catch(err => {
            console.log("failed rejecting participation:"+err);
        });  
        // self.loadParticipants();
    }
    undo(event) {
        event.preventDefault();
        var self = this;
        firestore.undoParticipation(event.target.id)
        .then( res =>{
            self.loadParticipants();
        })
        .catch(err => {
            console.log("failed rejecting participation:"+err);
        });  
        // self.loadParticipants();
    }
	render() {
		const { participants } = this.state;

		return (
			<React.Fragment>
				{ !! participants && 
					<div className="content">
						<h3>Deelnemers:</h3>
						<div className="participants">
							<table>
								<tr className='participant'>
									<th>Deelnemer</th>
									<th>Institutie</th>
									<th>Email</th>
									<th>Status</th>
									<th>Acties</th>
								</tr>
							{Object.keys(participants).map(key =>
								<tr className='participant'>
									<td><div className="table-el">{participants[key].name}</div></td>
									<td><div className="table-el">{participants[key].education}</div></td>
									<td><div className="table-el">{participants[key].email}</div></td>
									{ participants[key]["participationStatus"]===0 && <td><div className="table-el">In afwachting</div></td>}
									{ participants[key]["participationStatus"]===1 && <td><div className="table-el">Goedgekeurd</div></td>}
									{ participants[key]["participationStatus"]===2 && <td><div className="table-el">Geweigerd</div></td>}
									{ participants[key]["participationStatus"]===3 && <td><div className="table-el">Afgewerkt</div></td>}
									{ participants[key]["participationStatus"]===0 && 
										<td><div className="table-el">
											<button onClick={this.accept} id={participants[key]["participationId"]}>Accepteer</button>
											<button onClick={this.reject} id={participants[key]["participationId"]}>Weiger</button>
										</div></td>
									}
									{ participants[key]["participationStatus"]===1 && <td><div className="table-el"><button onClick={this.giveBadge} id={key}>Geef badge</button></div></td>}
									{ participants[key]["participationStatus"]===2 && <td><div className="table-el"><button onClick={this.undo} id={participants[key]["participationId"]}>Maak ongedaan</button></div></td>}
								</tr>
							)}
							</table>
						</div>
					</div>
				}
				{ ! participants && <EmptyList/> }
			</React.Fragment>
		)
	}
}

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

export default List;