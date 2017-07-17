class Products extends React.Component {
  constructor() {
    super()
    this.state = {}
    this.add = this.add.bind(this);
  }

  componentWillMount() {
    console.log(this.state)
    this.props.products.forEach( function(x,a) {
      this.setState({[x.id] : 0});
    }.bind(this));
  }

  componentDidMount() {
    var elements = document.getElementsByTagName('input');

    for (var i = 0; i < elements.length; i++) {
      elements[i].value = "2";
    }
  }

  add(id, amount) {
    var amount = Math.max(0, this.state[id] + amount)

    $.ajax({
      method: "POST",
      url: '/cart',
      data: {amount: amount, product_id: id},
      success: this.setState({[id]: amount})
    });
  }

  render() {
    var products = this.props.products.map( (product) => {
      var data_ref = product.id + "_amount"
      return(
        <div className="col-lg-4 col-md-4 col-sm-6 col-xs-6 item">
          <h3>{product.name}</h3>
          <img height='160' width='160' src={product.image_url} />
          <h4>{this.state[product.id]}</h4>
          <h4>{product.description}</h4>
          <button onClick={()=> this.add(product.id, 1) }>+</button>
          <button onClick={()=> this.add(product.id, -1) }>-</button>
        </div>
      )
    })

    return(
      <div>{products}</div>
    )
  }
}
