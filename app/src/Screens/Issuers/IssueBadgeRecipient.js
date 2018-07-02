import React, { Component } from 'react';
import { connect } from 'react-redux';

import {
	BadgeFetchList,
	BadgeIssueRecipient
} from './../../actions/badgesActions';

import Nav from './../../Components/Nav';
import Footer from './../../Components/Footer';
import FormIssueBadge from './../../Components/Badge/FormIssueBadge';

class IssueBadgeRecipient extends Component {
	constructor() {
    super();
		this.submit = this.submit.bind(this);
	};
	componentDidMount() {
		this.props.badgeFetchList();
	}
	submit() {
		console.log('submitting...', this.props.form.issueBadgeForm.values);
    this.props.issueBadge(
			{
				'badge_class': this.props.form.issueBadgeForm.values.badge,
				'create_notification': this.props.form.issueBadgeForm.values.create_notification,
				'evidence_items':[],
				'narrative':'',
				'recipient_identifier': this.props.form.issueBadgeForm.values.recipient,
				'recipient_type':'email'
			}
		);
  }
	render() {
		return (
			<div>
				<Nav/>
					<div className="container">
						<div className="content">
							<h1>Reward Badge Recipient</h1>
							<FormIssueBadge onSubmit={this.submit}/>
						</div>
					</div>
				<Footer/>
			</div>
		)
	}
}

export default (IssueBadgeRecipient = connect(
  (state) => {
    return {
			badge: state.badge,
			form: state.form
		};
  },
  (dispatch) => {
    return {
      issueBadge: (data) => {
        dispatch(BadgeIssueRecipient(data));
			},
			badgeFetchList: () => {
        dispatch(BadgeFetchList());
      }
    };
  }
)(IssueBadgeRecipient));