// create new address
// TODO need to add green check marks 
class CreateAddress extends React.Component {
  constructor() {
    super();
    this.state = {canSubmit: false};
    this.saveAddress = this.saveAddress.bind(this);
    this.clearAddress1 = this.clearAddress1.bind(this);
    this.clearAddress2 = this.clearAddress2.bind(this);
    this.validAddress1 = this.validAddress1.bind(this);
    this.validAddress2 = this.validAddress2.bind(this);
    this.updateState = this.updateState.bind(this);
    this.canSubmit = this.canSubmit.bind(this);
    this.onSuccess = this.onSuccess.bind(this)
  }

  saveAddress() {
    this.setState({canSubmit: false})

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
         this.onSuccess(response)
      }.bind(this)
    });
  }

  onSuccess(response) {
    this.clearAddress1()
    this.clearAddress2()
    this.props.onSuccess(response.uuid)

    // setTimeout(function() {
      
    //   this.setState({success: false})
    // }.bind(this), 2000)
  }

  componentDidUpdate() {
    if(this.state.canSubmit != this.canSubmit()) {
      this.setState({canSubmit: !this.state.canSubmit})
    }
  }

  validAddress1() {
    return(!!this.state.street_number && !!this.state.street_name && !!this.state.zip && !this.state.error)
  }

  validAddress2() {
    return(!!this.state.address_2)
  }

  canSubmit() {
    return(this.validAddress1() && this.validAddress2())
  }

  updateState(autocomplete) {
    this.setState({
      street_number: this.refs.street_number.value,
      street_name: this.refs.route.value,
      address_2: this.refs.address_2.value,
      city: this.refs.locality.value,
      state: this.refs.administrative_area_level_1.value,
      zip: this.refs.postal_code.value,
      google_place_id: this.refs.place_id.value,
    });

    if (autocomplete) {
      this.setState({autocomplete: true})
    }
  }

  clearAddress1() {
    if (this.state.autocomplete) {

      this.refs.autocomplete.value = ''

      this.setState({
        street_number: '',
        city: null,
        state: null,
        zip: null,
        google_place_id: null,
        autocomplete: false,
        error: null // clear any error if updating address
      });

      this.refs.street_number.value = null
      this.refs.route.value = null
      this.refs.locality.value = null
      this.refs.administrative_area_level_1.value = null
      this.refs.postal_code.value = null
      this.refs.place_id.value = null
    }
  }

  clearAddress2() {
    this.refs.address_2.value = null
    this.setState({address_2: null})
  }

  render() {
    var address_style = {
      display: 'inline-block',
      width: '80%'
    }

    var address_2_style = {
      width: '20%',
      display: 'inline-block'
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

    var complete_style = {
      height: '10px',
      width: '10px',
      color: 'green',
      padding: '5px',
      marginRight: '10px'
    }

    var incomplete_style = {
      color: 'grey',
      height: '10px',
      width: '10px',
      marginRight: '10px',
    }

    var address1Style = this.validAddress1() ? complete_style : incomplete_style
    var address2Style = this.validAddress2() ? complete_style : incomplete_style

    var errorStyle = {
      margin: '0px 10px 0px 10px',
      color: 'red'
    }

    var containerStyle = {
      textAlign: 'left'
    }

    return(
      <div>
        <div>
          <div className="base-title">New Address</div>
        </div>
        <div className="base-container" style={containerStyle}>
          {this.state.success ? <div>saved</div> : 
            <div>
              {this.state.error ? <h3 style={errorStyle}>{this.state.error}</h3> : null}
              <div id="locationField">
                <div>
                  <input  style={address_style} className="base-input" onClick={this.clearAddress1} onBlur={()=> setTimeout(function() {this.updateState(true)}.bind(this), 1000)} id="autocomplete" ref="autocomplete" placeholder="Address (start typing...)" type="text"></input><span style={address1Style} className="glyphicon glyphicon-ok"></span>
                </div>
                <div>
                  <input  style={address_2_style} className="base-input" onChange={this.updateState} ref="address_2" id="address_2" type='text' placeholder="Unit #"></input><span style={address2Style} className="glyphicon glyphicon-ok"></span>
                </div>
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
