import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { firestore } from './../Components/Firebase';

class OverOns extends Component {
    constructor(props) {
        super(props)

        this.state={
            text: ""
        }
    }
    componentDidMount() {
        window.scrollTo(0, 0);
        var self = this;
        firestore.onceGetOverOns().then(snapshot => {
            console.log("content:");
            console.log(snapshot.data().content);
            self.setState({text: snapshot.data().content});
        }).catch(function(error) {
            console.error("Error getting document: ", error);
        });
    }
    render() {
        return (
            <div>
                <div className="container">
                    <div className="content content-with-padding">
                        <div className="aboutcontent" dangerouslySetInnerHTML={{ __html: this.state.text }} />
                        </div>
                </div>
            </div>
        )
    }
}

export default OverOns;