import React from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';

import { BadgeIssueRecipient } from './../../actions/badgesActions';

import { renderInput, renderSelect, renderCheckbox } from './../Utils';

let FormIssueBadge = (props) => {
  const { 
    handleSubmit,
    submitting,
  } = props
  return(
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <Field
          id="badge"
          name="badge"
          label="Badge"
          // data={{
          //   list: badges.map((index, key) => {
          //     return {
          //       value: 'text with value for the request',
          //       display: 'text to be displayed'
          //     };
          //   })
          // }}
          component={renderSelect}
        />
        <Field
          label="Recipient"
          type="text"
          name="recipient"
          component={renderInput}
        />
        <Field
          type="checkbox"
          label="Send email to the recipient?"
          name="create_notification"
          component={renderCheckbox}
        />
      </div>
      <div className="form-group">
        <button type="submit" disabled={submitting}>
          Reward
        </button>
      </div>
    </form>
  )
}

FormIssueBadge = reduxForm({
  form: 'issueBadgeForm',
  fields: ['badge', 'recipient', 'create_notification']
})(FormIssueBadge);

export default (FormIssueBadge = connect(
  (state) => {
    return {};
  },
  (dispatch) => {
    return {
      issueBadge: (data) => {
        dispatch(BadgeIssueRecipient(data));
      }
    };
  }
)(FormIssueBadge));