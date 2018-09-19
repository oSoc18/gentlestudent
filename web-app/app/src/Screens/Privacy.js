import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { firestore } from './../Components/Firebase';


class Privacy extends Component {
  constructor(props) {
        super(props)

        this.state={
            text: ""
        }
    }
    componentDidMount() {
        window.scrollTo(0, 0);
        var self = this;
        firestore.onceGetPrivacyPage().then(snapshot => {
            console.log("content:");
            console.log(snapshot.data().content);
            self.setState({text: snapshot.data().content});
        }).catch(function(error) {
            console.error("Error getting document: ", error);
        });
    }
    render() {
        return (
            <React.Fragment>
                <div className="container">
                    <div className="content content-with-padding">
                        <div className="privacycontent" dangerouslySetInnerHTML={{ __html: this.state.text }} />
                    </div>
                    {/* <div className="container">
                        <div className="content">
                            <h1>Privacy</h1>
                            <p>This page informs you of our policies regarding the collection, use and disclosure of Personal Information we receive from users of the Site.</p>

                            <p></p>

                            <p>We use your Personal Information only for providing and improving the Site. By using the Site, you agree to the collection and use of information in accordance with this policy.</p>

                            <p></p>

                            <b>Information Collection And Use</b>

                            <p>While using our Site we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to your name (“Personal Information”).</p>

                            <p></p>

                            <b>Log Data</b>

                            <p>Like many site operators, we collect information that your browser sends whenever you visit our Site (“Log Data”). This Log Data may include information such as your computer’s Internet Protocol (“IP”) address, browser type, browser version, the pages of our Site that you visit, the time and date of your visit, the time spent on those pages and other statistics.</p>

                            <p></p>

                            <p>In addition, we may use third party services such as Google Analytics that collect, monitor and...</p>

                            <p></p>

                            <p>Last updated: 1/1/2018</p>
                        </div>
                    </div> */}
                </div>
            </React.Fragment>
        )
    }
}

export default Privacy;