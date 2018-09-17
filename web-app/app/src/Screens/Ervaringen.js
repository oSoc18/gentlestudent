import React, { Component } from 'react';

class Ervaringen extends Component {
    componentDidMount(){
        window.scrollTo(0, 0);
    }
    render() {
        return (
            <div>
                <div className="container">
                    <div className="content">
                        <h1>Ervaringen</h1>
                    </div>
                </div>
            </div>
        )
    }
}

export default Ervaringen;