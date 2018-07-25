import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

class Detail extends Component {
  render() {
    const { opportunities } = this.props;
    const id = this.props.match.params.id;

    return (
      <React.Fragment>
        { !! opportunities && <LeerkansDetail opportunity={ opportunities[id] } /> }
				{ ! opportunities && <EmptyList/> }
			</React.Fragment>
      
    )
  }
}

const LeerkansDetail = ({ opportunity }) =>
  <div>
    <a href="/leerkansen" className="back">&lt; Terug</a>
    {/* {JSON.stringify(opportunity)} */}
    {opportunity.shortDescription}
    {/* <h1>{opportunities[id].title}</h1>
    <p>{opportunities[id].description}</p> */}
  </div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>


export default Detail;
