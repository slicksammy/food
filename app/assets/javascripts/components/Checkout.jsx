class Checkout extends React.Component {
  constructor(props) {
    super(props);
    this.state = { address: props.order.address_uuid, stripe_token: props.order.stripe_token_uuid, expected_delivery_date: props.order.expected_delivery_date, newAddress: true, newPayment: true }
    this.confirmOrder = this.confirmOrder.bind(this);
    this.updateAddress = this.updateAddress.bind(this)
    this.updatePayment = this.updatePayment.bind(this)
    this.hideForver = this.hideForver.bind(this)
  }

  confirmOrder() {
    $.ajax({
      method: 'POST',
      url: '/order/confirm',
      success: function(response) {
        this.setState({success: true, orderNumber: response.order_number})
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
      success: function() {
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
      success: function() {
        this.setState({stripe_token: uuid, newPayment: false})
        this.togglePayment(false)
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
    return(this.state.address && this.state.stripe_token)
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



    var address = (
      <div className="col-xs-12 col-sm-9 col-md-6 col-lg-6" style={container}>
        <div hidden={!this.shouldShowCreateAddress()} id="create-address">
          <CreateAddress onSuccess={this.updateAddress}/>
          { this.state.address ? <button className="btn btn-danger" style={buttonStyle} onClick={()=>this.toggleCreateAddress(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowCreateAddress()} id="update-address">
          <UpdateOrder optionsUrl='/addresses' default={this.state.address} onUpdate={this.updateAddress} title="Choose Shipping Address" ref="address"/>
          <button className="btn" style={buttonStyle} hidden={!this.state.newAddress} onClick={()=>this.toggleCreateAddress(true)}>New Address</button>
        </div>
      </div>
    )

    var payment = (
      <div className="col-xs-12 col-sm-9 col-md-6 col-lg-6" style={container}>
        <div hidden={!this.shouldShowPayment()} id="create-payment">
          <Payment onSuccess={this.updateAddress}/>
          { this.state.payment ? <button className="btn btn-danger" style={buttonStyle} hidden={!this.state.stripe_token} onClick={()=>this.togglePayment(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowPayment()} id="update-payment">
          <UpdateOrder optionsUrl='/stripe' default={this.state.stripe_token} onUpdate={this.updatePayment} title="Choose Payment" ref="payment"/>
          <button className="btn" style={buttonStyle} hidden={!this.state.newPayment} onClick={()=>this.togglePayment(true)}>New Card</button>
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
      clear: 'none'
    }

    var form = ( 
      <div>
        <div>
          <Order items={this.props.items} order={this.props.order} />
        </div>
        {address}
        {payment}
        <div style={totalContainerStyle}>
          <h1>Total: ${this.props.order.total}</h1>
          {/*disable button on submit so customer doesn't try buying twice*/}
          <button style={buyButtonStyle} disabled={()=>this.canBuy()}className="btn btn-success" onClick={this.confirmOrder}>Buy</button>
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
