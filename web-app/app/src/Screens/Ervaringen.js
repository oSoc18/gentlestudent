import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';

import { firestore } from './../Components/Firebase';

import Detail from './../Components/Ervaringen/Detail';
import List from './../Components/Ervaringen/List';

class Ervaringen extends Component {
    constructor(props) {
		super(props);
	
		this.state = {
            experiences: null
		};
	  }
	componentDidMount() {
		window.scrollTo(0, 0);
		firestore.onceGetExperiences().then(snapshot => {
			var res = new Object()
			snapshot.forEach(doc => {
				res[doc.id] = doc.data();
			});
            this.setState(() => ({ experiences: res }))
            // console.log(this.state.newsItems);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
	}
	render() {
		const { experiences } = this.state;

		return (
            <Switch>
				<Route path={'/ervaringen/:id'} render={({match}) => <Detail experiences={experiences}  match={match}/>} />
				<Route path={'/ervaringen'} render={() => 
					<div className="news-items-content">
						<div className="container">
							<div className="content content-with-padding">
								<h1>Ervaringen</h1>
								<div id="nieuws">
									<List experiences={experiences} />
								</div>
							</div>
						</div>
                    </div>
				} />
			</Switch>
        )
    }
}

export default Ervaringen;