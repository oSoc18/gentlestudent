import React from 'react';
import { Field, reduxForm } from 'redux-form';

import { renderInput, renderSelect, renderCheckbox } from '../../../Shared/Utils';

let FormIssueBadge = (props) => {
  const { 
    handleSubmit,
    submitting,
    badge
  } = props;
  return(
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <Field
          id="badge"
          name="badge"
          label="Badge"
          data={{
            list: badge.list.map((index, key) => {
              return {
                value: index.slug,
                display: index.name
              };
            })
          }}
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

export default FormIssueBadge;