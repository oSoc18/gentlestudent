import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

import { auth, firestore } from './../Firebase';

class Detail extends Component {
  constructor(props){
    super(props);

    this.state={
      experiences: null,
      id: this.props.match.params.id
    };
  }
  componentDidMount(){
    if(this.props.experiences==undefined){
      firestore.onceGetExperience(this.state.id).then(doc => {
        if(doc.data()){
          this.setState(() => ({ experience: doc.data() }));
          // console.log(this.state.experiences);
        }
      })
      .catch(err => {
        console.log('Could not fetch experience data: ', err);
      });
    }
    else{
      this.setState(() => ({ experience: this.props.experiences[this.state.id] }));
    }
  }
  render() {
    const {experience, id} = this.state;

    return (
      <React.Fragment>
        { !! experience &&
            <NewsDetail experience={ experience } id={ id } />
        }
				{ ! experience && <EmptyList/> }
			</React.Fragment>
      
    )
  }
}

class NewsDetail extends Component {
  constructor(props){
    super(props);
    this.state = {
		};
  }
  componentDidMount() {
  }
  render() {
    const { experience, id } = this.props;

    return (
      <div className="opportunity-detail">
        <div className="overlay"></div>
        <div className="titlehead-wrapper" style={{backgroundImage: `url(${experience.imageUrl})`}}>
          <div className="titlehead">
            <div className="opportunity-container">
                {/* <h1>{experience.title}</h1> */}
            </div>
          </div>
        </div>
        <div id="page" className="opportunity-container">
          {/* <a href="/leerkansen" className="back">&lt; Terug</a> */}
          <div className="content content-flex">
            <div className="content-left">
              <h3>{experience.title}</h3>
              <p>{experience.longText}</p>
            </div>
            <div className="content-right">
              <br/>
              <div className="infobox">
                <h3>Info:</h3>
                <div className="infobox-content">
                  {/* <div className="content-left">
                    {!!issuer && <p><b>Eigenaar:</b><br/></p>}
                    {!!address && <p><b>Locatie:</b><br/></p>}
                    <p><b>Periode:</b><br/></p>
                    <p><b>Aantal deelnemers:</b><br/></p>
                  </div>
                  <div className="content-right">
                    {!!issuer && <p>{issuer.name}<br/></p>}
                    {!!address && <p>{address.street} {address.housenumber}, {address.postalcode} {address["city"]}<br/></p>}
                    <p>{experience.beginDate + ' tot en met ' + experience.endDate}<br/></p>
                    <p>{experience.participations}<br/></p>
                  </div> */}
                  <table>
                    {!!experience.author && <tr>
                      <td><b>Autheur:</b></td>
                      <td>{experience.author}</td>
                    </tr>}
                    <tr>
                      <td><b>Gepubliceerd op:</b></td>
                      <td>{experience.published}</td>
                    </tr>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <br/>
        <br/>
      </div>
    )
  }
}

const EmptyList = () =>
	<div>
		<Spinner />
	</div>


export default Detail;
