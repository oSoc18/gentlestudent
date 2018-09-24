import React, { Component } from 'react';
import { connect } from 'react-redux';
import { compose, withProps, withStateHandlers } from 'recompose';
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from 'react-google-maps';
import { InfoBox } from 'react-google-maps/lib/components/addons/InfoBox';

const apiKey = 'AIzaSyALLWUxYAWdEzUoSuWD8j2gVGRR05SWpe8';
// Gentlestudent style
const mapStyles = [{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#444444"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#46bcec"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"saturation":"17"},{"visibility":"on"},{"gamma":"2.52"},{"hue":"#00d4ff"}]}];
// Dark style
// const mapStyles2 = [{"featureType":"all","elementType":"geometry.fill","stylers":[{"weight":"2.00"}]},{"featureType":"all","elementType":"geometry.stroke","stylers":[{"color":"#9c9c9c"}]},{"featureType":"all","elementType":"labels.text","stylers":[{"visibility":"on"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"landscape.man_made","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#eeeeee"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#7b7b7b"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#ffffff"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#46bcec"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#c8d7d4"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#070707"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#ffffff"}]}];
const MapComponent = compose(
	withProps({
		googleMapURL:
			`https://maps.googleapis.com/maps/api/js?key=${apiKey}&v=3.exp&libraries=geometry,drawing,places`,
		loadingElement: <div style={{ height: `100%` }} />,
		containerElement: <div style={{ 
			// height: `calc(100vh - 346px)`,
			height: `calc(100vh - 150px)`,
			width: `100%`,
			position: `relative`,
	}} />,
		mapElement: <div style={{ height: `100%`, borderRadius: `8px` }} />
	}),
	withStateHandlers(() => ({
    isOpen: false,
  }), {
    onToggleOpen: ({ isOpen }) => () => ({
      isOpen: !isOpen,
		}),
		showInfo: ({ showInfo, isOpen}) => (i) => ({
			isOpen: !isOpen,
			showInfoIndex: i
		})
  }),
	withScriptjs,
	withGoogleMap
)(props => (
    <GoogleMap 
			defaultZoom={13}
			defaultCenter={{ lat: 51.0511164, lng: 3.7114566 }}
			defaultOptions={{ styles: mapStyles }}
    >
			{Object.keys(props.opportunities).map(key =>
					<React.Fragment key={key}>
						<Marker
							position={{ lat: props.addresses[props.opportunities[key].addressId].latitude, lng:  props.addresses[props.opportunities[key].addressId].longitude }}
							title={ props.issuers[props.opportunities[key].issuerId].name}
							onClick={()=>{ props.showInfo(key)}}
						>
							{props.showInfoIndex === key &&
								<InfoBox
									onCloseClick={props.onToggleOpen}
									options={{ closeBoxURL: ``, enableEventPropagation: true }}
								>
									<div style={{ backgroundColor: '#FFF', opacity: 0.95, padding: 15, width: 200 }}>
										<span style={{ fontSize: 16 , fontWeight: 'bold', display: 'block' }}>{props.opportunities[key].title}</span>
										<small>{props.opportunities[key].synopsis}</small>
									</div>
								</InfoBox>
							}
						</Marker>
					</React.Fragment>
				)
			}
    </GoogleMap>
));

class Maps extends Component {
	render() {
		return (
			<React.Fragment>
				{!! this.props.opportunities &&
					<MapComponent opportunities={this.props.opportunities} addresses={this.props.addresses} issuers={this.props.issuers}/>
				}
			</React.Fragment>
		)
	}
}

//the following code makes the div holding the google maps widget follow the scroll until the footer
window.onload = function() {
	//throttles a listener (like onscroll) to limit the amount of times the callback function gets called per second
	function throttler(ms, callback) {
		var timer;
	
		return function() {
			var self = this, args = arguments;
			clearTimeout(timer);
			timer = setTimeout(function() {
				callback.apply(self, args);
			}, ms);
		};
	}

	function getScrollTop() {
	  if (typeof window.pageYOffset !== 'undefined' ) {
		// Most browsers
		return window.pageYOffset;
	  }
  
	  var d = document.documentElement;
	  if (d.clientHeight) {
		// IE in standards mode
		return d.scrollTop;
	  }
  
	  // IE in quirks mode
	  return document.body.scrollTop;
	}
	
	window.onscroll = throttler(10, function() {
		var box = document.getElementById('stickybox'),
			scroll = getScrollTop();
		if(document.getElementById('stickybox')!=null){
			// console.log(scroll);
			if (scroll <= 200) {
				box.style.top = "0px";
			}
			else {
				console.log(box.style.top);
				console.log(box.parentElement.clientHeight-window.innerHeight+150);
				if(scroll-200<=box.parentElement.clientHeight-window.innerHeight+150){
					box.style.top = (scroll - 200) + "px";
				}
			}
		}
	});
}

export default Maps;