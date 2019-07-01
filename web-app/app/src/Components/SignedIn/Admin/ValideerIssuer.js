import React, { Component } from 'react';
import { Link } from 'react-router-dom';

import { firestore } from '../../../Utils/Firebase';

import Spinner from '../../../Shared/Spinner';

class ValideerIssuer extends Component {
  constructor() {
    super();
    // this.submit = this.submit.bind(this);
    this.state = {
		  issuers: null,
        };
        this.getIssuers = this.getIssuers.bind(this);
    };

    componentDidMount() {
        this.getIssuers();
        window.scrollTo(0, 0);
    }
    getIssuers() {
        firestore.onceGetNonValidatedIssuers().then(snapshot => {
            var res = new Object();
            snapshot.forEach(doc => {
                res[doc.id] = doc.data();
            });
            this.setState(() => ({ issuers: res }))
        })
        .catch(err => {
            console.log('Error getting documents', err);
        });
    }
  render() {
    const { issuers, getIssuers } = this.state;

    return (
        <React.Fragment>
            { !! issuers && <LeerkansenList issuers={ issuers } getIssuers={ this.getIssuers } /> }
            { !! issuers && Object.getOwnPropertyNames(issuers).length === 0 && <EmptyList/> }
            { ! issuers && <Loading/> }
        </React.Fragment>
    );
  }
}

class LeerkansenList extends Component{
    constructor(props) {
        super(props);

        this.state = {};

        this.handleClick = this.handleClick.bind(this);
      };
    
      handleClick(event) {
        console.log(event.target.id);
        firestore.validateIssuer(event.target.id);
        this.props.getIssuers();
      }

      render() {
        const { issuers } = this.props;
    
        return (
            <React.Fragment>
                <div className="container">
                    <div className="content">
                        <Link to="/" className="back">&lt; Terug</Link>
                        <h1>Valideer Issuer</h1>
                        <div className="card-container issuers">
                            {Object.keys(issuers).map(key =>
                                <div className={`card-item issuer`} key={issuers[key].addressId}>
                                    <h2>{issuers[key].name}</h2>
                                    <div className="meta-data">
                                    <small>institutie:{issuers[key].institution}</small>
                                    <small>tel.:{issuers[key].phonenumber}</small>
                                    <small>url:{issuers[key].url}</small>
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
                Er zijn geen te valideren issuers.
            </div>
        </div>
    </div>

const Loading = () =>
	<div>
		<Spinner />
	</div>

export default ValideerIssuer;
