import React from 'react';

// Components
export const renderInput = ({
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
        <input
          {...input}
          className="input"
          type={type}
          id={id}
          label={label}
          placeholder={placeholder}
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
          <option value="rDDaRFR1TIuy5k9rtk2geA">Duurzaamheid #1</option>
          <option value="C9W4vlkfRtOS4Ni9hhT-Pw">Ondernemerschap #2</option>
          {/* {data ?
            data.list.map((index, key) => {
              return (
                <option key={key} value={index.value}>
                  {index.display}
                </option>
              );
            }) : null
          } */}
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
