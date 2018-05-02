import React from 'react';
import { connect } from 'react-redux';

import { Field, reduxForm } from 'redux-form';

import { LeerkansCreateItem } from './../../actions/leerkansActions';

const renderInput = ({
  label,
  input,
  type,
  id,
  placeholder,
  defaultValue,
  value
}) => {
  return (
    <React.Fragment>
        <label htmlFor={label}>{label}</label>
        <input
          {...input}
          type={type}
          id={id}
          value={value}
          defaultValue={defaultValue}
          placeholder={placeholder}
        />
    </React.Fragment>
  );
};
const renderTextarea = ({
  label,
  input,
  type,
  id,
  placeholder,
  defaultValue,
  value
}) => {
  return (
    <React.Fragment>
        <label htmlFor={label}>{label}</label>
        <textarea
          {...input}
          type={type}
          id={id}
          rows="5"
          value={value}
          defaultValue={defaultValue}
          placeholder={placeholder}
        />
    </React.Fragment>
  );
};

let FormCreateLeerkans = (props) => {
  const { 
    handleSubmit,
    submitting,
  } = props
  return(
    <form onSubmit={handleSubmit}>
      <h2>(Loop all the fields before submitting -- will be fixed soon!)</h2>
      <div className="form-group">
        <Field
          label="Title"
          type="text"
          name="title"
          component={renderInput}
          defaultValue="test"
        />
      </div>
      <div className="form-group">
        <Field
          label="Synopsis"
          id="synopsis"
          name="synopsis"
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
          label="Badge"
          id="badge"
          name="badge"
          defaultValue="dg2"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Type (dg, dzh, ...)"
          id="type"
          name="type"
          defaultValue="dg"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Level (1, 2, 3)"
          id="level"
          name="level"
          defaultValue="2"
          component={renderInput}
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

export default (FormCreateLeerkans = connect(
  (state) => {
    return {};
  },
  (dispatch) => {
    return {
      createLeerkans: (data) => {
        dispatch(LeerkansCreateItem(data));
      }
    };
  }
)(FormCreateLeerkans));