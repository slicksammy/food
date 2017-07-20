class Order extends React.Component {
  constructor() {
    super();
    //this.order = this.order.bind(this);
  }

  // order() {
  //   $.ajax({
  //     url: '/checkout/buy',
  //     data: { order: order }
  //   })
  // }

  render() {

    var items = this.props.items.map( (product) => {
      return(<li className="item">{product.name}: {product.amount}lbs x {product.price}/lb = {product.total}</li>)
    });

    return(
      <div id="order">
        <ul>
          <u><h2 id="items-header">Items</h2></u>
          {items}
        </ul>
        <div className="total">Subtotal:<span className="float-right">{this.props.order.subtotal}</span></div>
        <div className="total">Tax: <span className="float-right">{this.props.order.tax}</span></div>
        <div className="total">Shipping: <span className="float-right">{this.props.order.shipping}</span></div>
        <div className="total">Total: <span className="float-right">{this.props.order.total}</span></div>
        {/*<button onClick={this.order}>Buy</button>*/}
      </div>
    )
  }
}
