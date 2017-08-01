class Cart extends React.Component {
  constructor(props) {
    super(props);
    this.state = { subtotal: props.subtotal}
    this.continueToCheckout = this.continueToCheckout.bind(this)
    this.updateSubtotal = this.updateSubtotal.bind(this)
  }

  continueToCheckout() {
    window.location = '/checkout'
  }

  updateSubtotal() {
    $.ajax({
      method: 'GET',
      url: '/cart/subtotal',
      success: function(response) {
        this.setState({subtotal: response.subtotal})
      }.bind(this)
    })
  }

  render() {
    var buttonStyle = {
      fontSize: '3vw',
      margin: '20px'
    }

    var buttonContainer = {
      textAlign: 'center',
      display: 'block'
    }

    var block = {
      display: 'block',
      backgroundColor: 'blue',
      width: '100%',
      height: '50px'
    }

    var subtotalStyle = {
      textAlign: 'center',
      fontSize: '3em'
    }

    return(
      <div>
        <div style={buttonContainer}>
          <button className="btn btn-success" style={buttonStyle} onClick={this.continueToCheckout}>Checkout >>></button>
        </div>
        <div style={subtotalStyle} className="row">
          Subtotal: ${this.state.subtotal}
        </div>
        <div className="row">
          <Products onChange={this.updateSubtotal} products={this.props.products} />
        </div>
        <div style={buttonContainer}>
          <button className="btn btn-success" style={buttonStyle} onClick={this.continueToCheckout}>Checkout >>></button>
        </div>
      </div>
    )
  }
}
