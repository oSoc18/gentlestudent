import React, { Component } from 'react';
import { connect } from 'react-redux';

import Nav from './../../Components/Nav';
import Footer from './../../Components/Footer';

import {
  LeerkansenFetch,
  LeerkansenDeleteItem
} from './../../actions/leerkansActions';

class BOLeerkansen extends Component {
  constructor(props) {
    super(props)

    this.delete = this.delete.bind(this);
  }
  componentDidMount() {
	  this.props.fetchLeerkansen();
	}
  delete(id) {
    this.props.deleteLeerkans(id);
  }
  render() {
    return (
      <React.Fragment>
        <Nav />
        {
          this.props.leerkansen.items.map((lk, key) => {
            return(
              <div key={key}>
                <p>
                  {lk.title}
                </p>
                <a onClick={() => this.delete(lk._id)}>Delete</a>
              </div>
            )
          })
        }
        <Footer />
      </React.Fragment>
    )
  }
}

export default connect(
	(state) => {
		return {
			leerkansen: state.leerkansen
		};
	},
	(dispatch) => {
		return {
			fetchLeerkansen: () => {
				dispatch(LeerkansenFetch());
      },
      deleteLeerkans: (id) => {
        dispatch(LeerkansenDeleteItem(id));
      }
		}
	}
)(BOLeerkansen);