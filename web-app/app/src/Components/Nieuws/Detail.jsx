import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

import { auth, firestore } from './../Firebase';

class Detail extends Component {
  constructor(props){
    super(props);

    this.state={
      newsItems: null,
      id: this.props.match.params.id
    };
  }
  componentDidMount(){
    if(this.props.newsItems==undefined){
      firestore.onceGetNewsItem(this.state.id).then(doc => {
        if(doc.data()){
          this.setState(() => ({ newsItem: doc.data() }));
          // console.log(this.state.newsItems);
        }
      })
      .catch(err => {
        console.log('Could not fetch newsItem data: ', err);
      });
    }
    else{
      this.setState(() => ({ newsItem: this.props.newsItems[this.state.id] }));
    }
  }
  render() {
    const {newsItem, id} = this.state;

    return (
      <React.Fragment>
        { !! newsItem &&
            <NewsDetail newsItem={ newsItem } id={ id } />
        }
				{ ! newsItem && <EmptyList/> }
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
    const { newsItem, id } = this.props;

    return (
      <div className="opportunity-detail">
        <div className="overlay"></div>
        <div className="titlehead-wrapper" style={{backgroundImage: `url(${newsItem.imageUrl})`}}>
          <div className="titlehead">
            <div className="opportunity-container">
                {/* <h1>{newsItem.title}</h1> */}
            </div>
          </div>
        </div>
        <div id="page" className="opportunity-container">
          {/* <a href="/leerkansen" className="back">&lt; Terug</a> */}
          {/* <div className="content content-flex">
            <div className="content-left">
              <h3>{newsItem.title}</h3>
              <p>{newsItem.longText}</p>
            </div>
            <div className="content-right">
              <br/>
              <div className="infobox">
                <h3>Info:</h3>
                <div className="infobox-content">
                  <table>
                    {!!newsItem.author && <tr>
                      <td><b>Auteur:</b></td>
                      <td>{newsItem.author}</td>
                    </tr>}
                    <tr>
                      <td><b>Gepubliceerd op:</b></td>
                      <td>{newsItem.published}</td>
                    </tr>
                  </table>
                </div>
              </div>
            </div>
          </div> */}
          <div className="content news-item-content">
            <h3>{newsItem.title}</h3>
            <small>{newsItem.author}</small><br/>
            <small>{newsItem.published}</small>
            <p>{newsItem.longText}</p>
            <br/>
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
