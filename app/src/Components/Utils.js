import React from 'react';
import { Link, Route} from 'react-router-dom';
import Dropzone from 'react-dropzone';

import { css } from 'glamor';
import { $primary, $sub, $orange, $green, $white, $gray, $grayL, $transition } from './../variables';

// Call To Action (CTA)
export const cta = css({
	position: 'relative',
	width: 'calc(100% - 60px)',
	height: 42,
	background: $white,
	padding: 15,
	marginBottom: 30,
	transition: $transition,
	'&.fixed': {
		position: 'fixed',
		width: '100% !important',
		top: 100,
		left: 0,
		zIndex: 1,
		borderBottom: `1px solid ${$grayL}`,
		'> .primary': {
			position: 'absolute',
			top: 15,
			left: 15,
			padding: '10px 15px !important',
			fontSize: '16px',
		}
	},
	'> .primary': {
		display: 'block',
		fontSize: '24px',
		fontWeight: '600',
		textAlign: 'center',
		width: 150,
		margin: '0 auto',
		padding: '15px 30px'
	}
});

export const stepsIssuer = css({
  '> .steps': {
    color: $white,
    '> .step': {
      height: 150,
      marginBottom: 30,
      '&:nth-of-type(1)': { background: $sub },
      '&:nth-of-type(2)': { background: $orange },
      '&:nth-of-type(3)': { background: $green },
      '&:nth-of-type(4)': { background: $primary },
      '> div': {
        display: 'flex',
        flexDirection: 'row',
        '> span.step-number': {
          fontSize: 72,
          fontWeight: 600,
          lineHeight: '150px',
          padding: '0 20px'
        },
        '> div': {
          '> h3': {},
          '> p': {
            fontSize: 14,
            paddingRight: 30
          }
        },
        '> img': {}
      }
    }
  }
});

const breadcrumb = css({
  fontWeight: 600,
  fontSize: 12,
  marginTop: 30,
  color: $gray,
  '> a': {
    color: $gray,
    '&.home::after': {
      content:"﹥",
      margin: '0 3px'
    },
    '&.breadcrumb-active': {
      color: $primary,
    },
    '&:hover': {
      textDecoration: 'underline'
    }
  }
});

// Breadcrumbs
const BreadcrumbsItem = ({ ...rest, match }) => (
  <span>
    <div {...breadcrumb}>
      <Link to="/" className="home">home</Link>
      <Link to={match.url || ''} className={match.isExact ? ' breadcrumb-active' : null}>
        {match.url}
      </Link>
    </div>
    <Route path={`${match.url}:path`} component={BreadcrumbsItem} />
  </span>
)

export const Breadcrumbs = () => (
  <div className="breadcrumbs">
    <div className="container">
      <div className="content">
        <Route path='/:path' component={BreadcrumbsItem} />
      </div>
    </div>
  </div>
)

// Components
export const renderInput = ({
  label,
  input,
  type,
  id,
  defaultValue,
  placeholder,
  meta: { asyncValidating, touched, error }
}) => {
  return (
    <React.Fragment>
      <div
        // className={
        //   touched && error
        //     ? `${errorMessage}`
        //     : touched && !error ? `${succesMessage}` : null
        // }
      >
        <label htmlFor={input.name}>
          {label}
        </label>
        <input
          {...input}
          className="input"
          type={type}
          id={id}
          label={label}
          placeholder={placeholder}
          required
        />
        {touched && error && <span className="error">{error}</span>}
        {touched && !error && <span className="succes">✓</span>}
      </div>
    </React.Fragment>
  );
};

export const renderAutomaticInput = ({
  label,
  input,
  type,
  id,
  defaultValue,
  placeholder,
  meta: { asyncValidating, touched, error }
}) => {
  return (
    <React.Fragment>
      <div
        // className={
        //   touched && error
        //     ? `${errorMessage}`
        //     : touched && !error ? `${succesMessage}` : null
        // }
      >
        <label htmlFor={input.name}>
          {label}
        </label>
        <input
          {...input}
          className="input"
          type={type}
          id={id}
          label={label}
          placeholder={placeholder}
          value={defaultValue}
          required
        />
        {touched && error && <span className="error">{error}</span>}
        {touched && !error && <span className="succes">✓</span>}
      </div>
    </React.Fragment>
  );
};

export const renderCheckbox = ({ label, input, type, id }) => {
  return (
    <React.Fragment>
      <div>
        <label htmlFor={input.name}>{label}</label>
        <input
          {...input}
          className="checkbox"
          type={type}
          id={id}
        />
      </div>
    </React.Fragment>
  );
};

export const renderSelect = ({
  label,
  input,
  data,
  meta: { asyncValidating, touched, error }
}) => {
  return (
    <React.Fragment>
      <div
        // className={
        //   touched && error
        //     ? `${errorMessage}`
        //     : touched && !error ? `${succesMessage}` : null
        // }
      >
        <label htmlFor={input.name} >
          {label}
        </label>
        <select
          {...input}
          className="select"
          required
        >
          <option value="">— Select an option —</option>
          {data.list.map((index, key) => {
            return (
              <option key={key} value={index.value} required>
                {index.display}
              </option>
            );
          })}
        </select>
        {touched && error ? <span className="error">{error}</span> : null}
      </div>
    </React.Fragment>
  );
};

export const renderTextarea = ({
  label,
  input,
  type,
  id,
  placeholder,
  meta: { asyncValidating, touched, error }
}) => {
  return (
    <React.Fragment>
      <div
        // className={
        //   touched && error
        //     ? `${errorMessage}`
        //     : touched && !error ? `${succesMessage}` : null
        // }
      >
        <label htmlFor={input.name}>
          {label}
        </label>
        <textarea
          className="textarea"
          {...input}
          type={type}
          id={id}
          label={label}
          placeholder={placeholder}
          rows="6"
          cols="50"
          required
        />
        {touched && error && <span className="error">{error}</span>}
        {touched && !error && <span className="succes">✓</span>}
      </div>
    </React.Fragment>
  );
};

export const RenderDropzoneInput = (field) => {
  const files = field.input.value;
  return (
    <div>
      <Dropzone
        name={field.name}
        onDrop={( filesToUpload, e ) => field.input.onChange(filesToUpload)}
        required
      >
        <div>Try dropping some files here, or click to select files to upload.</div>
      </Dropzone>
      {field.meta.touched &&
        field.meta.error &&
        <span className="error">{field.meta.error}</span>}
      {files && Array.isArray(files) && (
        <ul>
          { files.map((file, i) => <li key={i}>{file.name}</li>) }
        </ul>
      )}
    </div>
  );
};

export const validate = values => {
  const errors = {};
  if (!values.title) {
    errors.title = "Required";
  }
  if (!values.synopsis){
    errors.synopsis = "Required";
  }
  if (!values.description){
    errors.description = "Required";
  }
  if (!values.start_date){
    errors.start_date = "Required";
  }
  if (!values.end_date){
    errors.end_date = "Required";
  }
  if (!values.street){
    errors.street = "Required";
  }
  if (!values.house_number){
    errors.house_number = "Required";
  }
  if (!values.postal_code){
    errors.postal_code = "Required";
  }
  if (!values.city){
    errors.city = "Required";
  }
  if (!values.country){
    errors.country = "Required";
  }
  if (!values.latitude){
    errors.street = "Required";
  }
  if (!values.longitude){
    errors.street = "Required";
  }
  return errors;
};

