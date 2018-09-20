import React, { Component } from 'react';

class SearchFilters extends Component {
  constructor(props) {
		super(props);
	
    this.state = {}
  }
  // filterTouched(event){
  //   console.log("kaas");
  // }
  render() {
    return (
      <React.Fragment>
        <div className="searchfilters">
          <div className="fixed">
            <h1>Leerkansen</h1>
            <form action="">
              <div className="search-wrapper leerkansen">
                <i className="fas fa-search"></i>
                <input type="text" placeholder="zoeken" onChange={this.props.filterFunction}/>
                  {/* <div className="filters">
                    <button onClick={(e) => e.preventDefault()}>Leerkansen</button>
                    <button onClick={(e) => e.preventDefault()}>Niveaus</button>
                    <button onClick={(e) => e.preventDefault()}>Periode</button>
                    <button onClick={(e) => e.preventDefault()}>Afstand</button>
                  </div> */}
              </div>
            </form>
          </div>
        </div>
      </React.Fragment>
    )
  }
}

export default SearchFilters;