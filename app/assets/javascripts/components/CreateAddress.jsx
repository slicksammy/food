// create new address
class CreateAddress extends React.Component {
  constructor() {
    super();
    this.state = {canSubmit: false};
    this.saveAddress = this.saveAddress.bind(this);
    this.toggleSubmit = this.toggleSubmit.bind(this)
  }

  saveAddress() {
    var address = {
      street_number: this.refs.street_number.value,
      street_name: this.refs.route.value,
      address_2: this.refs.address_2.value,
      city: this.refs.locality.value,
      state: this.refs.administrative_area_level_1.value,
      zip: this.refs.postal_code.value,
      google_place_id: this.refs.place_id.value,
    };

    var coordinates = {
      lat: this.refs.lat.value,
      lng: this.refs.lng.value,
    }

    $.ajax({
      method: 'POST',
      url: '/address',
      data: { address: address, coordinates: coordinates},
      error: function(response) {
        this.setState({error: response.responseJSON.error})
      }.bind(this)
    });
  }

  toggleSubmit() {
    if (street_number.value && route.value && postal_code.value && autocomplete.value) {
      this.setState({canSubmit: true})
    } else {
      this.setState({canSubmit: false})
    }
  }

  render() {
    return(
      <div>
        {this.state.error ? <h3>{this.state.error}</h3> : null}
        <link rel="stylesheet" type="text/css" href="assets/address.css" />
        <div id="locationField">
          <input onChange={()=> setTimeout(function() {this.toggleSubmit()}.bind(this), 1000)} id="autocomplete" placeholder="Enter your address" type="text"></input>
        </div>
        <input ref="address_2" type='text'></input>
        <data id="street_number" ref="street_number"/>
        <data id="route" ref="route"/>
        <data id="locality" ref="locality"/>
        <data id="administrative_area_level_1" ref="administrative_area_level_1"/>
        <data id="postal_code" ref="postal_code"/>
        <data id="place-id" ref="place_id"/>
        <data id="lat" ref="lat"/>
        <data id="lng" ref="lng"/>
        <button disabled={!this.state.canSubmit} className="btn btn-success" onClick={this.saveAddress}>Save</button>
      </div>
    )
  }
}
