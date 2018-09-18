import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link, withRouter } from 'react-router-dom';

import FormCreateLeerkans from './../../Components/Leerkansen/FormCreateLeerkans';

import { firestore } from './../../Components/Firebase';

import { Category, Difficulty} from '../../Components/Leerkansen/Constants';

const CreateLeerkansPage = ({ history, match }) =>
  <div>
    <CreateLeerkans history={history} match={match}/>
  </div>

class CreateLeerkans extends Component {
  constructor(props) {
    super(props);
    // this.submit = this.submit.bind(this);
    this.state = {
      badges: null,
      initValues: null
		};
  };
  componentDidMount() {
    window.scrollTo(0, 0);
		firestore.onceGetBadges().then(snapshot => {
			var res = new Object();
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
			this.setState(() => ({ badges: res }))
		})
		.catch(err => {
			console.log('Error getting documents', err);
    });
    var self = this;
    if(this.props.match.params.id!=undefined){
      firestore.onceGetOpportunity(this.props.match.params.id).then(snapshot => {
        var start_date= snapshot.data().beginDate;
        // var category= self.getEnumValue(Category, snapshot.data().category);
        var category= snapshot.data().category;
        // var difficulty= self.getEnumValue(Difficulty, snapshot.data().difficulty);
        var difficulty = snapshot.data().difficulty;
        var end_date= snapshot.data().endDate;
        var description= snapshot.data().longDescription;
        var oppImageUrl= snapshot.data().oppImageUrl;
        var synopsis= snapshot.data().shortDescription;
        var title= snapshot.data().title;
        var moreInfo= snapshot.data().moreInfo;
        var website= snapshot.data().website;
        firestore.onceGetAddress(snapshot.data().addressId).then(snapshot => {
          self.setState({
            initValues: {
              start_date: start_date,
              category: category,
              city: snapshot.data().city,
              country: snapshot.data().country,
              difficulty: difficulty,
              end_date: end_date,
              description: description,
              house_number: snapshot.data().housenumber,
              latitude: snapshot.data().latitude,
              longitude: snapshot.data().longitude,
              oppImageUrl: oppImageUrl,
              postal_code: snapshot.data().postalcode,
              street: snapshot.data().street,
              synopsis: synopsis,
              title: title,
              moreInfo: moreInfo,
              website: website
            }
          });
        }).catch(function(error) {
          console.error("Error getting document: ", error);
        });
        console.log(self.state.initValues);
      }).catch(function(error) {
        console.error("Error getting document: ", error);
      });
    }
    else{
      this.stateopportunity=new Object;
    }    
  }
  getEnumValue(enumTable, i){
    var keys = Object.keys(enumTable).sort(function(a, b){
      return enumTable[a] - enumTable[b];
    }); //sorting is required since the order of keys is not guaranteed.
    
    var getEnum = function(ordinal) {
      return keys[ordinal];
    }

    return getEnum(i);
  }
  // submit() {
  //   /* 
  //   * Get the badge from state
  //   * Findindex in the state and get the name
  //   * Split the name in 2 and automatically assign level and type to the database without inputs
  //   */
  //    const index = this.props.badge.list.findIndex(b => {
  //     return b.slug === this.props.form.createLeerkansForm.values.badge
  //   });
  //   const nameBadge = this.props.badge.list[index].name.split(' #');
  //   this.props.createLeerkans(
  //     {
  //       ...this.props.form.createLeerkansForm.values,
  //       type: nameBadge[0].replace(' ', '-').toLowerCase(),
  //       level: nameBadge[1]
  //     }
  //   );
  //   console.log(this.props.form.createLeerkansForm.values.image);
  //   console.log(this.props.form.createLeerkansForm.values);
  // }
  showResults = (values) =>
    new Promise(resolve => {
      window.alert(`You submitted:\n\n${JSON.stringify(values, null, 2)}`)
      resolve()
    })
  render() {
    const { badges, initValues } = this.state;
    const { history, match } = this.props;

    return (
      <div>
        <div className="container">
          <div className="content">
            <Link to="/aangemaakte-leerkansen" className="back">&lt; Terug</Link>
            <h1>Maak Leerkans</h1>
            <div className="form" id="create_leerkans">
              {/* <FormCreateLeerkans onSubmit={this.submit} badges={badges}/> */}
              {/* <FormCreateLeerkans badges={badges} history={history} opportunity={opportunity}/> */}
              {/* {!initValues && <FormCreateLeerkans badges={badges} history={history}/>} */}
              {/* {!!initValues && <FormCreateLeerkans badges={badges} history={history} initialValues={initValues}/>} */}
              <FormCreateLeerkans badges={badges} history={history} initialValues={initValues} initValues={initValues}/>
            </div>
          </div>
        </div>
    </div>
    );
  }
}

export default withRouter(CreateLeerkansPage);
