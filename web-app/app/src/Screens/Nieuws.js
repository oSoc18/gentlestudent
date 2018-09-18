import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';

import { firestore } from './../Components/Firebase';

import Detail from './../Components/Nieuws/Detail';
import List from './../Components/Nieuws/List';

class Nieuws extends Component {
    constructor(props) {
		super(props);
	
		this.state = {
		  newsItems: null
		};
	  }
	componentDidMount() {
		window.scrollTo(0, 0);
		firestore.onceGetNewsItems().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
            this.setState(() => ({ newsItems: res }))
            // console.log(this.state.newsItems);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
	}
	render() {
		const { newsItems } = this.state;

		return (
            <Switch>
				<Route path={'/nieuws/:id'} render={({match}) => <Detail newsItems={newsItems}  match={match}/>} />
				<Route path={'/nieuws'} render={() => 
					<div className="news-items-content">
						<div className="container">
							<div className="content content-with-padding">
								<h1>Nieuws</h1>
								<div id="nieuws">
									<List newsItems={newsItems} />
								</div>
							</div>
						</div>
                    </div>
				} />
			</Switch>
        )
    }
}

export default Nieuws;