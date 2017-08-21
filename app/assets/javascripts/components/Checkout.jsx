class Checkout extends React.Component {
  constructor(props) {
    super(props);
    this.state = { address: props.order.address_uuid, stripe_token: props.order.stripe_token_uuid, expected_delivery_date: props.order.expected_delivery_date, newAddress: true, newPayment: true }
    this.confirmOrder = this.confirmOrder.bind(this);
    this.updateAddress = this.updateAddress.bind(this)
    this.updatePayment = this.updatePayment.bind(this)
    this.updateDelivery = this.updateDelivery.bind(this)
    this.hideForver = this.hideForver.bind(this)
  }

  confirmOrder() {
    $.ajax({
      method: 'POST',
      url: '/order/buy',
      success: function() {
        window.location = '/orders'
      },
      error: function() {
        this.setState({error: true })
      }.bind(this)
    });
  }

  toggleAddress(val) {
    this.setState({address: val})
  }

  updateAddress(uuid) {
    $.ajax({
      method: 'POST',
      url: 'order/update',
      data: { order: {address: uuid} },
      success: function(response) {
        this.setState({address: uuid, newAddress: false})
        this.toggleCreateAddress(false)
      }.bind(this)
    })
  }

  updatePayment(uuid) {
    $.ajax({
      method: 'POST',
      url: 'order/update',
      data: { order: {stripe_token: uuid} },
      success: function(response) {
        this.setState({stripe_token: uuid, newPayment: false})
        this.togglePayment(false)
      }.bind(this)
    })
  }

  updateDelivery(date) {
    $.ajax({
      method: 'POST',
      url: 'order/update',
      data: { order: {expected_delivery_date: date} },
      success: function(response) {
        this.setState({expected_delivery_date: date})
      }.bind(this)
    })
  }

  shouldShowCreateAddress() {
    return(!this.state.address || this.state.showAddress)
  }

  shouldShowPayment() {
    return(!this.state.stripe_token || this.state.showPayment)
  }

  toggleCreateAddress(val) {
    this.setState({showAddress: val})
  }

  togglePayment(val) {
    this.setState({showPayment: val})
  }

  hideForver(e) {
    e.display = 'none'
  }

  canBuy() {
    return(this.state.address && this.state.stripe_token && !this.state.error)
  }


  render() {
    var buttonStyle = {
      float: 'left',
      clear: 'both',
      marginTop: '20px'
    }

    var containerStyle = {
      display: 'inline-block',
      backgroundColor: '#ff3333',
      borderRadius: '25px',
    }

    var container = {
      margin: '40px 0px 40px 0px',
      float: 'left'
    }

    var canCancelAddress = this.state.address ? { display: 'none' } : {}

    var canCancelPayment = this.state.payment ? { display: 'none' } : {}

    var colCentered = {
      display: 'inline-block',
      float: 'none',
      margin: '20px 0px 20px 0px',
      fontSize: '24px'
    }

    var address = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <div hidden={!this.shouldShowCreateAddress()} id="create-address">
          <CreateAddress onSuccess={this.updateAddress}/>
          { this.state.address ? <button className="btn" style={buttonStyle} onClick={()=>this.toggleCreateAddress(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowCreateAddress()} id="update-address">
          <UpdateOrder optionsUrl='/addresses' default={this.state.address} onUpdate={this.updateAddress} title="Shipping Address" ref="address"/>
          <button className="btn" style={buttonStyle} hidden={!this.state.newAddress} onClick={()=>this.toggleCreateAddress(true)}>New Address</button>
        </div>
      </div>
    )

    var payment = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <div hidden={!this.shouldShowPayment()} id="create-payment">
          <Payment onSuccess={this.updatePayment}/>
          { this.state.stripe_token ? <button className="btn" style={buttonStyle} onClick={()=>this.togglePayment(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowPayment()} id="update-payment">
          <UpdateOrder optionsUrl='/stripe' default={this.state.stripe_token} onUpdate={this.updatePayment} title="Payment" ref="payment"/>
          <button className="btn" style={buttonStyle} hidden={!this.state.newPayment} onClick={()=>this.togglePayment(true)}>New Card</button>
        </div>
      </div>
    )

    var delivery = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <div id="update-delivery">
          <UpdateOrder default={this.state.expected_delivery_date} onUpdate={this.updateDelivery} options={this.props.delivery_options} title="Delivery Date" ref="delivery"/>
        </div>
      </div>
    )

    var buyButtonStyle = {
      width: '50%',
      height: '3em',
      fontSize: '3em',
      dispaly: 'inline-block',
      paddingBottom: '20px'
    }

    var totalContainerStyle = {
      textAlign: 'center',
      marginBottom: '50px',
      clear: 'both'
    }

    var errorStyle = {
      color: 'red'
    }

    var centered = {
      textAlign: 'center',
      display: 'block'
    }

    var form = ( 
      <div>
        <div style={centered}>
          <div style={colCentered} className="col-xs-12 col-sm-9 col-md-9 col-lg-9">
            <Order items={this.props.items} order={this.props.order} />
          </div>
        </div>
        <div style={centered}>
          {address}
        </div>
        <div style={centered}>
          {payment}
        </div>
        <div style={centered}>
          {delivery}
        </div>
        <div style={totalContainerStyle}>
          <h1>Total: ${this.props.order.total}</h1>
          { this.state.error ? <h2 style={errorStyle}>There was an error. Please update your information and try again.</h2> : null}
          {/*disable button on submit so customer doesn't try buying twice*/}
          <button style={buyButtonStyle} disabled={!this.canBuy()}className="btn btn-success" onClick={this.confirmOrder}>Buy</button>
        </div> 
      </div>
    )

    return(
      <div> {this.state.success ? <OrderSuccess orderNumber={this.state.orderNumber}/> : form } </div>
    )  
  }
}

const OrderSuccess = (props) => {
  return( 
    <div>
      Congrats your order has been placed. Your order # is {props.orderNumber}
    </div>
  )
}
