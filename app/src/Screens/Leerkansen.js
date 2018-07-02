import React, { Component } from 'react';

import Nav from './../Components/Nav';
import LeerkansenApp from './../Components/Leerkansen/LeerkansenApp';
import Maps from './../Components/Leerkansen/Maps';
import SearchFilter from './../Components/Leerkansen/SearchFilters';

class Leerkansen extends Component {
	render() {
		return (
			<div>
				<Nav/>
				<div className="content">
					<SearchFilter />
					<div id="leerkansen">
						<div className="content-left">
							<LeerkansenApp />
						</div>
						<div className="content-right">
							<div className="content">
								<Maps />
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

export default Leerkansen;