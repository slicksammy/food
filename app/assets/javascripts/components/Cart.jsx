class Cart extends React.Component {
  constructor() {
    super();
    this.continueToCheckout = this.continueToCheckout.bind(this)
  }

  continueToCheckout() {
    window.location = '/checkout'
  }

  render() {
    var buttonStyle = {
      fontSize: '3vw',
      margin: '20px'
    }

    var buttonContainer = {
      textAlign: 'center'
    }

    return(
      <div>
        <div style={buttonContainer}>
          <button className="btn btn-success" style={buttonStyle} onClick={this.continueToCheckout}>Checkout >>></button>
        </div>
        <Products products={this.props.products} />
        <div style={buttonContainer}>
          <button className="btn btn-success" style={buttonStyle} onClick={this.continueToCheckout}>Checkout >>></button>
        </div>
      </div>
    )
  }
}
