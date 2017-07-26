class Products extends React.Component {
  constructor() {
    super()
    this.state = {}
    this.add = this.add.bind(this);
  }

  componentWillMount() {
    this.props.products.forEach( function(x,a) {
      this.setState({[x.uuid] : [x.amount]});
    }.bind(this));
  }

  add(uuid, amount) {
    var amount = Math.max(0, parseInt(this.state[uuid]) + amount)
    console.log(uuid)
    $.ajax({
      method: "POST",
      url: '/cart',
      data: {amount: amount, product_id: uuid},
      success: this.setState({[uuid]: amount})
    });
  }

  render() {
    var products = this.props.products.map( (product) => {
      return(
        <div className="col-lg-4 col-md-4 col-sm-6 col-xs-6 item">
          <h3>{product.name}</h3>
          <img height='160' width='160' src={product.image_url} />
          <h4>{this.state[product.uuid]}</h4>
          <h4>{product.description}</h4>
          <button onClick={()=> this.add(product.uuid, 1) }>+</button>
          <button onClick={()=> this.add(product.uuid, -1) }>-</button>
          <button onClick={()=> this.add(product.uuid, -1000000) }>remove</button>
        </div>
      )
    })

    return(
      <div>{products}</div>
    )
  }
}
