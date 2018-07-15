import React from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';

import { renderInput} from './../Utils';

let FormLoginUser = (props) => {
  const { 
    handleSubmit,
    submitting
  } = props
  return(
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <Field
          label="E-mail"
          id="email"
          name="email"
          type="text"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Password"
          id="password"
          name="password"
          type="password"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <button type="submit" disabled={submitting}>
          Login
        </button>
      </div>
    </form>
  )
}

FormLoginUser = reduxForm({
  form: 'loginUser',
  fields: ['email', 'password']
})(FormLoginUser);

export default (FormLoginUser = connect(
  (state) => {
    return {};
  },
  (dispatch) => {
    return {};
  }
)(FormLoginUser));