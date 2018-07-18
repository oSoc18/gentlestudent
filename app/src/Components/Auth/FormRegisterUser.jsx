import React from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';

import { renderInput} from './../Utils';

let FormRegisterUser = (props) => {
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
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <Field
          label="Password"
          id="password"
          name="password"
          component={renderInput}
        />
      </div>
      <div className="form-group">
        <button type="submit" disabled={submitting}>
          Register
        </button>
      </div>
    </form>
  )
}

FormRegisterUser = reduxForm({
  form: 'registerUser',
  fields: ['email', 'password']
})(FormRegisterUser);

export default FormRegisterUser;