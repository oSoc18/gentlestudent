import React from 'react';
import { Field, reduxForm, formValueSelector } from 'redux-form';

let FormCreateLeerkans = (props) => {
  const { handleSubmit, pristine, reset, submitting } = props
  return(
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="title">Title</label>
        <Field 
          type="text"
          name="title"
          component="input"
        />
      </div>
      <div className="form-group">
        <label htmlFor="synopsis">Synopsis</label>
        <Field
          id="synopsis"
          name="synopsis"
          component="input"
        />
      </div>
      <div className="form-group">
      <button type="submit" disabled={submitting}>
          Submit
        </button>
      </div>
    </form>
  )
}

FormCreateLeerkans = reduxForm({
  form: 'formCreateLeerkans',
  fields: ['title', 'synopsis']
})(FormCreateLeerkans);

export default FormCreateLeerkans;