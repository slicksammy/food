// should disable the check button after you get a response but should reenable on change
class CheckAvailability extends React.Component {
  constructor() {
    super();
    this.state = {canSubmit: false, showForm: true};
    this.checkAvailability = this.checkAvailability.bind(this);
    this.toggleSubmit = this.toggleSubmit.bind(this)
  }

  checkAvailability() {
    // should do nothing unless lat and lng are avail
    // adding street number bc in google you can search by zip and it will return geo coordinates

    if (lat.value && lng.value && street_number.value) {
      $.ajax({
        method: 'POST',
        url: '/address/availability',
        data: { coordinates: {lat: lat.value, lng: lng.value} },
        success: function(response) {
          this.setState({available: response.available, showForm: false})
        }.bind(this)
      })
    }
  }

  toggleSubmit(val) {
    if (!val) {
      this.setState({canSubmit: false})
    } else {
      // only allow submit if we toggle and there are values and they have changed
      // if meets condition set state
      if (lat.value && lat.value != this.state.lat) {
        this.setState({canSubmit: true, lat: lat.value})
      }
    }
  }

  // currently google writes to the data fields but does not clear them first
  // ie someone could have a street number then update to a city the street number will still be there
  render() {
    var inputStyle = {
      border: 'none',
      outline: 'none',
      borderBottom: 'solid 5px',
      height: '50px',
      width: '100%',
      fontSize: '3em',
      textAlign: 'center'
    }

    var form = (
      <div>
        <div id="locationField">
          <input style={inputStyle} onBlur={()=> setTimeout(function() {this.checkAvailability()}.bind(this), 1000)} id="autocomplete" placeholder="Check our Availability" type="text"></input>
        </div>
        <data id="street_number" ref="street_number"/>
        <data id="route" ref="route"/>
        <data id="locality" ref="locality"/>
        <data id="administrative_area_level_1" ref="administrative_area_level_1"/>
        <data id="postal_code" ref="postal_code"/>
        <data id="place-id" ref="place_id"/>
        <data onInput={this.log} id="lat" ref="lat"/>
        <data id="lng" ref="lng"/>
      </div>
    )

    var baseStyle = {
      fontSize: '40px',
      textAlign: 'center'
    }



    return(
      <div>
        { this.state.showForm ? form : null }
        { this.state.available ? <div style={baseStyle}>Yay! We Sure Are!</div> : null }
        { this.state.available === false ? <div style={baseStyle}>Unfortunately Not But Once We Are We Will Let You Know!</div> : null }
      </div>
    )
  }
}
