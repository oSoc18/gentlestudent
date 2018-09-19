import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import AuthUserContext from './../../Components/AuthUserContext';
import { auth, firestore } from './../../Components/Firebase';
import firebase from 'firebase';

import Spinner from '../../Components/Spinner';

class Backpack extends Component {
  constructor(props) {
    super(props)

    this.state={
        backpack: null
    }

    this.downloadBadge = this.downloadBadge.bind(this);
    }
    componentDidMount() {
        window.scrollTo(0, 0);
        var self = this
        firebase.auth().onAuthStateChanged((user) => {
            if (user) {
                let id = user.uid;
                // console.log(id);
                //fetching assertions
                firestore.onceGetAssertions(id).then(snapshot => {
                    var res = new Object();
                    snapshot.forEach(doc => {
                        let key = doc.id;
                        res[key] = doc.data();
                        firestore.onceGetBadge(res[key].badgeId).then(doc => {
                            res[key]['badge'] = doc.data();
                            self.setState(() => ({ backpack: res }));
                        }).catch(err => {
                            console.log('Error getting document', err);
                        });
                    });
                })
                .catch(err => {
                    console.log('Error getting documents', err);
                });
            }
        });
    }
    downloadBadge(){
        console.log("Deze feature is nog niet geimplementeerd.");
    }
  render() {
    const { backpack } = this.state;
    return (
      <React.Fragment>
          <div className="container">
                <div className="content content-with-padding">
                    <h1>Backpack</h1>
                    {!!backpack && <div className="backpack">
                        {Object.keys(backpack).map(key =>
                            <div className="backpack-item">
                                <img src={backpack[key]['badge'].image ? `${backpack[key]['badge'].image}` : null}/>
                                <button className="download-badge" onClick={this.downloadBadge}>Download</button>
                            </div>
                        )}
                    </div>}
                    {!backpack && 
                        <LoadingList/>
                    }
                </div>
            </div>
      </React.Fragment>
    )
  }
}

const LoadingList = () =>
	<div>
		<Spinner />
	</div>

export default Backpack;