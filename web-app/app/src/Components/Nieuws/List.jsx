import React, { Component } from 'react';
import { connect } from 'react-redux';

import Spinner from '../Spinner';

class List extends Component {
	render() {
		const { newsItems } = this.props;

		return (
			<React.Fragment>
				{ !! newsItems && <NewsList newsItems={ newsItems } /> }
				{ ! newsItems && <EmptyList/> }
			</React.Fragment>
		)
	}
}

const NewsList = ({ newsItems }) =>
	<div>
		<div class="l-container">
			<ul>
			{Object.keys(newsItems).map(key =>
                // <p>{key}</p>
                <a href={`nieuws/${key}`}>
                    <li class="news-item">
                    <article class="post">
                        <div className="crop-news-img">
                            <img className="news-img" src={newsItems[key].imageUrl ? `${newsItems[key].imageUrl}` : null} alt="Article thumbnail" />
                        </div>
                        <h1>{newsItems[key].title}</h1>
                        {!!newsItems[key].published && <small><time datetime={newsItems[key].published}>{newsItems[key].published}</time></small>}
                        {!!newsItems[key].author && <small>{newsItems[key].author}</small>}
                        <p>{newsItems[key].shortText}</p> 
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