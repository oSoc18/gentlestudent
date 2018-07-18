import React from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';

import { renderInput, renderTextarea, renderSelect, RenderDropzoneInput } from './../Utils';

let FormCreateLeerkans = (props) => {
  const { 
    handleSubmit,
    submitting,
    badge
  } = props
  return(
    <form onSubmit={handleSubmit} encType="multipart/form-data">
      <h2>(Loop all the fields before submitting -- will be fixed soon!)</h2>
      <div className="form-group">
        <Field
          label="Title"
          type="text"
          name="title"
          component={renderInput}
          defaultValue="Test title"
        />
      </div>
      <div className="form-group">
        <Field
          label="Synopsis"
          type="text"
          name="synopsis"
          id="synopsis"
          component={renderTextarea}
        />
      </div>
      <div className="form-group">
        <Field
          label="Description"
          id="description"
          name="description"
          component={renderTextarea}
        />
      </div>
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
      </div>
      <div className="form-group">
        <Field
          label="Start Date (DD/MM/JJJJ)"
          id="start_date"
          name="start_date"
          defaultValue="01/03/2018"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="End Date (DD/MM/JJJJ)"
          id="end_date"
          name="end_date"
          defaultValue="01/06/2018"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Latitude"
          id="latitude"
          name="latitude"
          defaultValue="51.086793"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Longitude"
          id="longitude"
          name="longitude"
          defaultValue="3.6661196"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Street"
          id="street"
          name="street"
          defaultValue="Rooigemlaan"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="House Number"
          id="house_number"
          name="house_number"
          defaultValue="123"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Postal Code"
          id="postal_code"
          name="postal_code"
          defaultValue="9000"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="City"
          id="city"
          name="city"
          defaultValue="Gent"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Country"
          id="country"
          name="country"
          defaultValue="Belgie"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          name="image"
          component={RenderDropzoneInput}
        />
      </div>
      <div className="form-group">
        <button type="submit" disabled={submitting}>
          Add leerkans
        </button>
      </div>
    </form>
  )
}

FormCreateLeerkans = reduxForm({
  form: 'createLeerkansForm',
  fields: ['title', 'synopsis']
})(FormCreateLeerkans);

export default FormCreateLeerkans;