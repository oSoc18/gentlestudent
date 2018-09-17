import React, { Component } from 'react';

class OverOns extends Component {
    componentDidMount(){
        window.scrollTo(0, 0);
    }
    render() {
        return (
            <div>
                <div className="container">
                    <div className="content content-with-padding">
                        <h1>Over Ons</h1>
                    </div>
                </div>
            </div>
        )
    }
}

export default OverOns;