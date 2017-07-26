class Checkout extends React.Component {
  constructor() {
    super();
    this.state = {}
    this.confirmOrder = this.confirmOrder.bind(this)
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

  render() {
    var form = ( 
      <div>
        <div>
          <Order items={this.props.items} order={this.props.order} />
        </div>
        <div> 
          {/*<CreateAddress />*/}
        </div>
        <div className="checkout-item clear-float-left" ref="address">
          <CreateAddress />
        </div>
        <div className="checkout-item clear-float-left" ref="address">
          {/*<UpdateOrder options={this.props.payments}/>*/}
          {/*<UpdateOrder options={this.props.addresses} param="address_id" title="Choose Shipping Address" ref="address"/>*/}
          <button>Continue</button>
          {/*<ChoosePayment options={this.props.payments}/>*/}
          {/*<CreditCard />*/}
        </div>
        <div className="checkout-item clear-float-left">
          {/*<UpdateOrder options={this.props.payments} param="stripe_token_id" title="Choose Payment Method"/>*/}
          <button>Continue</button>
        </div>
        <div className="clear-float-left">
          <h1>Total: $200</h1>
          {/*disable button on submit so customer doesn't try buying twice*/}
          <button className="buy" onClick={this.confirmOrder}>Buy</button>
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
