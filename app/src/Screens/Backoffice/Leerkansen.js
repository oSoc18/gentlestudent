import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

class BOLeerkansen extends Component {
  constructor(props) {
    super(props)

    this.delete = this.delete.bind(this);
  }
  componentDidMount() {
	  // this.props.fetchLeerkansen();
	}
  delete(id) {
    // this.props.deleteLeerkans(id);
  }
  render() {
    return (
      <React.Fragment>
        <div className="container">
          <div className="content">
            <h1>Manage Leerkansen</h1>
            <button><Link to="/backoffice/create-leerkansen"> + Create leerkans</Link></button><hr />
            {
              this.props.leerkansen.items.map((lk, key) => {
                return(
                  <div key={key}>
                    <p>
                      {lk.title}
                    </p>
                    <button onClick={() => this.delete(lk._id)}>Delete</button><hr />
                  </div>
                )
              })
            }
          </div>
        </div>
      </React.Fragment>
    )
  }
}

export default BOLeerkansen;