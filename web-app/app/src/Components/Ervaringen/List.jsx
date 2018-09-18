import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

class List extends Component {
	render() {
		const { experiences } = this.props;

		return (
			<React.Fragment>
				{ !! experiences  && <ExperiencesList experiences={ experiences } /> }
				{ ! experiences && <EmptyList/> }
			</React.Fragment>
		)
	}
}

const ExperiencesList = ({ experiences }) =>
	<div>
		<div class="l-container">
			<ul>
			{Object.keys(experiences).map(key =>
                // <p>{key}</p>
                <a href={`ervaringen/${key}`}>
                    <li class="news-item">
                    <article class="post">
                        <div className="crop-news-img">
                            <img src={experiences[key].imageUrl ? `${experiences[key].imageUrl}` : null} alt="Article thumbnail" />
                        </div>
                        <h1>{experiences[key].title}</h1>
                        {!!experiences[key].published && <small><time datetime={experiences[key].published}>{experiences[key].published}</time></small>}
                        {!!experiences[key].author && <small>{experiences[key].author}</small>}
                        <p>{experiences[key].shortText}</p> 
                    </article>
                    </li>
                </a>
            )}
            </ul>
		</div>
	</div>

const EmptyList = () =>
	<div>
		<Spinner />
	</div>

export default List;