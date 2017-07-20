class Cart extends React.Component {
  render() {
    return(
      <div id="cart">
        { this.props.products.length > 0 ? <Products products={this.props.products} /> : 'Nothing Here, Keep Shopping' }
        {/*<button>Checkout</button>*/}
      </div>
    )
  }
}
