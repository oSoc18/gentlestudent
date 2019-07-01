import React, { Component } from 'react';
import { firestore } from '../../Utils/Firebase';


class Voorwaarden extends Component {
  constructor(props) {
    super(props)

    this.state={
        text: ""
    }
    }
    componentDidMount() {
        window.scrollTo(0, 0);
        var self = this;
        firestore.onceGetVoorwaarden().then(snapshot => {
            console.log("content:");
            console.log(snapshot.data().content);
            self.setState({text: snapshot.data().content});
        }).catch(function(error) {
            console.error("Error getting document: ", error);
        });
    }
    render() {
        const {text} = this.state;
        return (
            <React.Fragment>
                <div class="content content-with-padding">
                    <div class="privacycontent" dangerouslySetInnerHTML={{ __html: this.state.text }} />
                </div>
            </React.Fragment>
        )
    }
}

export default Voorwaarden;