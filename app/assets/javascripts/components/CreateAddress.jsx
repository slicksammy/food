// create new address
class CreateAddress extends React.Component {
  constructor() {
    super();
    this.saveAddress = this.saveAddress.bind(this);
  }

  saveAddress() {
    var params = {
      street_number: this.refs.street_number.value,
      street_name: this.refs.route.value,
      address_2: this.refs.address_2.value,
      city: this.refs.locality.value,
      state: this.refs.administrative_area_level_1.value,
      zip: this.refs.postal_code.value,
      google_place_id: this.refs.place_id.value,
    };

    $.ajax({
      method: 'POST',
      url: '/address',
      data: { address: params}, 
    });
  }

  render() {
    return(
      <div>
        <link rel="stylesheet" type="text/css" href="assets/address.css" />
        <GoogleAddress />
        <input ref="address_2" type='text'></input>
        <data id="street_number" ref="street_number"/>
        <data id="route" ref="route"/>
        <data id="locality" ref="locality"/>
        <data id="administrative_area_level_1" ref="administrative_area_level_1"/>
        <data id="postal_code" ref="postal_code"/>
        <data id="place-id" ref="place_id"/>
        <data id="lat" ref="lat"/>
        <data id="lng" ref="lng"/>
        <button className="btn btn-success" onClick={this.saveAddress}>Save</button>
      </div>
    )
  }
}
