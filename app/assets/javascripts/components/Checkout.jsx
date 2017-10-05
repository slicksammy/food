class Checkout extends React.Component {
  constructor(props) {
    super(props);
    this.state = { order: props.order,  promo: props.order.promo, promoSuccess: !!props.order.promo, address: props.order.address_uuid, stripe_token: props.order.stripe_token_uuid, expected_delivery_date: props.order.expected_delivery_date, newAddress: true, newPayment: true }
    this.confirmOrder = this.confirmOrder.bind(this);
    this.updateAddress = this.updateAddress.bind(this);
    this.updatePayment = this.updatePayment.bind(this);
    this.updateDelivery = this.updateDelivery.bind(this);
    this.hideForver = this.hideForver.bind(this);
    this.applyPromo = this.applyPromo.bind(this);
    this.showSuccess = this.showSuccess.bind(this);
    this.updatePromo = this.updatePromo.bind(this)
    this.canApplyPromo = this.canApplyPromo.bind(this);
  }

  confirmOrder(e) {
    e.target.disabled = true
    var instructions = this.refs.instructions.value

    this.setState({loader: true})

    $.ajax({
      method: 'POST',
      url: '/order/buy',
      data: { order: this.state.order, instructions: instructions },
      success: function() {
        this.showSuccess()
      }.bind(this),
      error: function(response) {
        this.setState({error: 'oops there was an error, please refresh the page and try again', loader: false })
      }.bind(this)
    });
  }

  showSuccess() {
    this.setState({success: true, loader: false})
    setTimeout(function() {window.location = '/orders', 2000})
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

  applyPromo() {
    var code = this.state.promo

    $.ajax({
      method: 'POST',
      url: 'order/promo',
      data: { code: code },
      success: function(response) {
        this.setState({order: response.order, promoSuccess: true})
      }.bind(this),
      error: function(response) {
        this.setState({promoError: response.responseJSON.error || 'there was an error please try again' })
      }.bind(this)
    })
  }

  updatePromo(e) {
    this.setState({ promo: e.target.value})
  }

  canApplyPromo() {
    return(this.state.promo)
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
    return(this.state.address && this.state.stripe_token && !this.state.error && this.props.accepting_orders)
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
          { this.state.address ? <button className="btn btn-default" style={buttonStyle} onClick={()=>this.toggleCreateAddress(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowCreateAddress()} id="update-address">
          <UpdateOrder optionsUrl='/addresses' default={this.state.address} onUpdate={this.updateAddress} title="Shipping Address" ref="address"/>
          <button className="btn btn-default" style={buttonStyle} hidden={!this.state.newAddress} onClick={()=>this.toggleCreateAddress(true)}>New Address</button>
        </div>
      </div>
    )

    var payment = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <div hidden={!this.shouldShowPayment()} id="create-payment">
          <Payment onSuccess={this.updatePayment}/>
          { this.state.stripe_token ? <button className="btn btn-default" style={buttonStyle} onClick={()=>this.togglePayment(false)}>Cancel</button> : null }
        </div>
        <div hidden={this.shouldShowPayment()} id="update-payment">
          <UpdateOrder optionsUrl='/stripe' default={this.state.stripe_token} onUpdate={this.updatePayment} title="Payment" ref="payment"/>
          <button className="btn btn-default" style={buttonStyle} hidden={!this.state.newPayment} onClick={()=>this.togglePayment(true)}>New Card</button>
        </div>
      </div>
    )

    var warningStyle = {
      fontSize: '24px',
    }

    var delivery = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <p style={warningStyle}>Orders will arrive between <strong>3pm</strong> and <strong>7pm</strong> and must be put in the fridge or freezer by <strong>10pm</strong> to stay fresh.</p>
        <div id="update-delivery">
          <UpdateOrder default={this.state.expected_delivery_date} onUpdate={this.updateDelivery} options={this.props.delivery_options} title="Delivery Date" ref="delivery"/>
        </div>
      </div>
    )

    var header_style = {
      width: '100%'
    }

    var container_style = {
      width: '100%',
      textAlign: 'center'
    }

    var promo_style = {
      width: '100%',
      display: 'inline-block',
      textAlign: 'left'
      // background: '#d0cbcb',
      // borderBottom: 'none'
    }

    var promo_button_style = {
      display: 'inline-block',
      width: '30%',
    }

    var errorStyle = {
      color: 'red'
    }

    // TODO disable button until something is in the input box
    var promoForm = (
      <div>
        <div>
          { this.state.promoError ? <div style={errorStyle}>{this.state.promoError}</div> : null }
          <input onChange={this.updatePromo} style={promo_style} className="base-input" type='text' placeholder="Enter code" ref="promo"></input> 
        </div>
        <div className="centered">
          <button disabled={!this.canApplyPromo()} className="btn btn-success base-button" onClick={this.applyPromo}>Apply</button>
        </div>
      </div>
    )

    var promo = (
      <div className="col-xs-9 col-sm-9 col-md-4 col-lg-4" style={colCentered}>
        <div>
          <div style={header_style} className='base-title'>Promo Code</div>
        </div>
        <div style={container_style} className='base-container'>
          { this.state.promoSuccess ? <div>{this.state.promo}</div> : promoForm }
        </div>
      </div>
    )

    var textAreaStyle = {
      width: '80%',
      fontSize: '14px',
      border: 'solid 2px black'
      // height: '50px'
    }

    var instructions = (
      <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9" style={colCentered}>
        <p>We are not responsible for theft, so please make sure to let us know where the best place to leave your steaks is.</p>
        <div>
          <div style={header_style} className='base-title'>Delivery Instructions</div>
        </div>
        <div style={container_style} className='base-container'>
          <textarea ref="instructions" rows="4" style={textAreaStyle} placeholder="Best place to leave your package, door code, etc. (optional)" />
        </div>
      </div>
    )

    var buyButtonStyle = {
      width: '25%',
      // height: '3em',
      fontSize: '3em',
      display: 'inline-block',
      paddingBottom: '20px',
      minHeight: '100px',
      minWidth: '120px'
    }

    var totalContainerStyle = {
      textAlign: 'center',
      marginBottom: '50px',
      clear: 'both',
      opacity: this.state.loader || this.state.success ? .1 : 1
    }

    var centered = {
      textAlign: 'center',
      display: 'block',
      opacity: this.state.loader || this.state.success ? .1 : 1
    }

    var noOrdersStyle = {
      color: 'red',
      textAlign: 'center',
      marginBottom: '30px'
    }

    var form = ( 
      <div>
        {this.props.accepting_orders ? null : <h1 style={noOrdersStyle} >We apologize but we are currently not accepting orders. Please check back soon.</h1> }
        {this.state.loader ? <div className="loader"></div> : null }
        {this.state.success ? <div className="success"><span className=" glyphicon glyphicon-ok"></span>Congrats! Purhcase Complete.</div> : null }
        <div style={centered}>
          <div>
            <Order items={this.props.items} order={this.state.order} />
          </div>
        </div>
        <div style={centered}>
          {promo}
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
        <div style={centered}>
          {instructions}
        </div>
        <div style={totalContainerStyle}>
          <h1>Total: ${this.state.order.total}</h1>
          { this.state.error ? <h2 style={errorStyle}>{this.state.error}</h2> : null}
          {/*disable button on submit so customer doesn't try buying twice*/}
          <button style={buyButtonStyle} disabled={!this.canBuy()} className="btn btn-success" onClick={this.confirmOrder}>Buy</button>
        </div> 
      </div>
    )

    return(
      <div>{ form }</div>
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
