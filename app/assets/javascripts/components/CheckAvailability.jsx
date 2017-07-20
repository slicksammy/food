class CheckAvailability extends React.Component {
  constructor() {
    super();
    this.checkAvailability = this.checkAvailability.bind(this);
  }

  checkAvailability() {
    // should do nothing unless lat and lng are avail

    var lat = this.refs.lat.value
    var lng = this.refs.lng.value

    if (lat && lng) {
      $.ajax({
        method: 'POST',
        url: '/address/availability',
        data: { address: {lat: lat, lng: lng} }
      })
    }
  }


  render() {
    return(
      <div>
        <GoogleAddress />
        <data id="street_number" ref="street_number"/>
        <data id="route" ref="route"/>
        <data id="locality" ref="locality"/>
        <data id="administrative_area_level_1" ref="administrative_area_level_1"/>
        <data id="postal_code" ref="postal_code"/>
        <data id="place-id" ref="place_id"/>
        <data id="lat" ref="lat"/>
        <data id="lng" ref="lng"/>
        <button onClick={this.checkAvailability}>Check</button>
      </div>
    )
  }
}
