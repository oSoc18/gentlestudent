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
          value={defaultValue}
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
        >
          <option>— Select an option —</option>
          {data.list.map((index, key) => {
            return (
              <option key={key} value={index.value}>
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
        />
        {touched && error && <span className="error">{error}</span>}
        {touched && !error && <span className="succes">✓</span>}
      </div>
    </React.Fragment>
  );
};

export const ReduxFormDropzone = (field) => {
    let {
      input,
      meta,
      dropzoneOnDrop,
      dropzoneRef,
      value,
      ...props
    } = field;
    return (
      <Dropzone
        {...input}
        accept="image/jpeg, image/png"
        // ref={(node) => { dropzoneRef = node; }}
        {...props}
        onDrop={(acceptedFiles, rejectedFiles, e) => {
            alert(JSON.stringify(acceptedFiles));
            field.input.onChange(acceptedFiles);
            field.dropzoneOnDrop && field.dropzoneOnDrop(acceptedFiles, rejectedFiles, e);
        }}
      >
        <p>Drop your image here.</p>
      </Dropzone>
    );
}
