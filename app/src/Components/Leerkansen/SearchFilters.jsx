import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class SearchFilters extends Component {
  constructor() {
    super()
  }
  render() {
    return (
      <React.Fragment>
        <div className="relative searchfilters">
          <div className="fixed">
            <h1>
              Leerkansen - 
              <small><Link to="/create-leerkansen"> Create leerkans</Link></small>
            </h1>
            <form action="">
              <div className="search-wrapper leerkansen">
                <i className="fas fa-search"></i>
                <input type="text" placeholder="zoeken"/>
                  <div className="filters">
                    <button onClick={(e) => e.preventDefault()}>Leerkansen</button>
                    <button onClick={(e) => e.preventDefault()}>Niveaus</button>
                    <button onClick={(e) => e.preventDefault()}>Periode</button>
                    <button onClick={(e) => e.preventDefault()}>Afstand</button>
                  </div>
              </div>
            </form>
          </div>
        </div>
      </React.Fragment>
    )
  }
}

export default SearchFilters;