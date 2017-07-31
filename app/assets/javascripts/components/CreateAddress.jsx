// create new address
class CreateAddress extends React.Component {
  constructor() {
    super();
    this.state = {canSubmit: false};
    this.saveAddress = this.saveAddress.bind(this);
    this.toggleSubmit = this.toggleSubmit.bind(this)
    this.clearData = this.clearData.bind(this)
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
        this.setState({error: response.responseJSON.error, canSubmit: false})
      }.bind(this),
      success: function(response) {
        this.setState({success: true}); 
        this.props.onSuccess(response.uuid)
      }.bind(this)
    });
  }

  toggleSubmit() {
    if (street_number.value && route.value && postal_code.value && address_2.value) {
      this.setState({canSubmit: true})
    } else {
      this.setState({canSubmit: false})
    }
  }

  clearData() {
    if(this.state.canSubmit) {
      $('data').each( function(index, element) {
        element.value = null
      });

      this.toggleSubmit()
    }
  }

  render() {
    var address_style = {
      width: '70%',
      height: '50px',
      display: 'inline-block',
      fontSize: '24px',
      border: 'grey solid',
      outline: 'none',
      margin: '5px',
    }

    var address_2_style = {
      width: '10%',
      height: '50px',
      display: 'inline-block',
      fontSize: '24px',
      border: 'grey solid',
      margin: '5px',
    }

    var buttonStyle = {
      margin: '10px',
      width: '100px',
      height: '40px',
      fontSize: '24px',
      padding: '5px',
      textAlign: 'center'
    }

    var containerStyle = {
      display: 'inline-block',
      textAlign: 'center',
      backgroundColor: '#ff3333',
      borderRadius: '25px'
    }

    return(
      <div>
        <div>
          <div className="base-title">New Address</div>
        </div>
        <div className="base-container centered">
          {this.state.success ? <Success /> : 
            <div>
              {this.state.error ? <h3>{this.state.error}</h3> : null}
              <div id="locationField">
                <input style={address_style} onChange={this.clearData} onBlur={()=> setTimeout(function() {this.toggleSubmit()}.bind(this), 1000)} id="autocomplete" ref="autocomplete" placeholder="Address (start typing...)" type="text"></input>
                <input style={address_2_style} onChange={this.toggleSubmit} ref="address_2" id="address_2" type='text' placeholder="Unit #"></input>
              </div>
              <data id="street_number" ref="street_number"/>
              <data id="route" ref="route"/>
              <data id="locality" ref="locality"/>
              <data id="administrative_area_level_1" ref="administrative_area_level_1"/>
              <data id="postal_code" ref="postal_code"/>
              <data id="place-id" ref="place_id"/>
              <data id="lat" ref="lat"/>
              <data id="lng" ref="lng"/>
              <button style={buttonStyle} disabled={!this.state.canSubmit} className="btn btn-success" onClick={this.saveAddress}>Save</button>
            </div>
          }
        </div>
      </div>
    )
  }
}

const Success = () => {
  return (
    <div>
      <h2>Saved!</h2>
    </div>
  )
}
