import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import AuthUserContext from './../../Components/AuthUserContext';
import { auth, firestore } from './../../Components/Firebase';
import firebase from 'firebase';

class Profiel extends Component {
  constructor(props) {
    super(props)

    this.state={
        birthdate:"",
        education:"",
        email:"",
        institute:"",
        name:"",
        pic:"",
        requestedIssuer:false,
        isIssuer:false,
        isAdmin:false,
    }
  }
  componentDidMount() {
      var self = this
    firebase.auth().onAuthStateChanged((user) => {
        if (user) {
            let id = user.uid;
            // console.log(id);
            firestore.onceGetParticipant(id).then(doc => {
                var res = new Object();
                if(doc.data()){
                    self.setState(() => ({ birthdate: doc.data().birthdate }));
                    self.setState(() => ({ education: doc.data().education }));
                    self.setState(() => ({ email: doc.data().email }));
                    self.setState(() => ({ institute: doc.data().institute }));
                    self.setState(() => ({ name: doc.data().name }));
                    if(doc.data().profilePicture){
                        self.setState(() => ({ pic: doc.data().profilePicture }));
                    }
                }
            })
            .catch(err => {
                console.log('Error getting documents', err);
            });
            firestore.onceGetIssuer(id).then(doc => {
                self.setState(() => ({ requestedIssuer: true }));
                if(doc.data()){
                    if(doc.data().validated){
                        self.setState(() => ({ isIssuer: true }));
                        self.setState(() => ({ requestedIssuer: false }));
                    }
                }
            })
            .catch(err => {
                console.log('User is not an issuer', err);
            });
            firestore.onceGetAdmin(id).then(doc => {
                var res = new Object();
                if(doc.data()){
                    self.setState(() => ({ isAdmin: true }));
                }
            })
            .catch(err => {
                console.log('User is not an admin', err);
            });
        }
    });
}
  render() {
    return (
      <React.Fragment>
        {/* <div className="container"> */}
          <div className="profile-page">
            <div class="profile">
                <div class="half left">
                    {this.state.pic!=="" && <img src={this.state.pic} alt="" />}
                    <span class="name">{this.state.name}</span>
                </div>
                <div class="half right">
                    <div class="info">
                    <span class="title">Email</span>
                    <i class="desc">{this.state.email}</i>
                    <span class="title">Geboortedatum</span>
                    <i class="desc">{this.state.birthdate}</i>
                    <span class="title">Institutie</span>
                    <i class="desc">{this.state.institute}</i>
                    <span class="title">Educatie</span>
                    <i class="desc">{this.state.education}</i>
                    {(!!this.state.requestedIssuer || !!this.state.isIssuer || !!this.state.isAdmin) && 
                        <React.Fragment>
                            <span class="title">Rollen</span>
                            {this.state.requestedIssuer && <i class="desc">Issuer status aangevraagd</i>}
                            {this.state.isIssuer && <i class="desc">Gevalideerde issuer</i>}
                            {this.state.isAdmin && <i class="desc">Admin</i>}
                        </React.Fragment>
                    }
                    </div>
                </div>
            </div>
            {/* <h1>Mijn profiel</h1>
            <ul>
                <li>Naam: {this.state.name}</li>
                <li>Geboortedatum: {this.state.birthdate}</li>
                <li>Email: {this.state.email}</li>
                <li>Institutie: {this.state.institute}</li>
                <li>Educatie: {this.state.education}</li>
                <br/>
                <ul>Rollen:

                {this.state.requestedIssuer && <li>Issuer status aangevraagd</li>}
                {this.state.isIssuer && <li>Gevalideerde issuer</li>}
                {this.state.isAdmin && <li>Admin</li>}
                {!this.state.requestedIssuer && !this.state.isIssuer && !this.state.isAdmin && <li>Geen</li>}
                </ul>
            </ul> */}
          </div>
        {/* </div> */}
      </React.Fragment>
    )
  }
}

export default Profiel;