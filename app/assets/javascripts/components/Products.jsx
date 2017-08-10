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

    $.ajax({
      method: "POST",
      url: '/cart',
      data: {amount: amount, product_id: uuid},
      success: function() {
        this.setState({[uuid]: amount})
        this.props.onChange()
      }.bind(this)
    });
  }

  toggleShowDescription(uuid, val) {
    var key = "show_" + uuid
    current = this.state[key]
    this.setState({[key]: val})
  }

  showDescription(uuid) {
    var key = "show_" + uuid
    return(this.state[key])
  }

  hasProduct(uuid) {
    return(this.state[uuid] > 0)
  }


  render() {
    var products = this.props.products.map( (product) => {
      var imageStyle = {
        width: '100%',
        height: '200px'
      }

      var containerStyle = {
        textAlign: 'center',
        paddingTop: '10px',
        maxWidth: '100%'
      }

      var buttonStyle = {
        margin: '10px'
      }

      var mainContainerStyle = {
        margin: '20px 0px 20px 0px'
      }

      var descriptionStyle = {
        position: 'absolute',
        top: '0',
        bottom: '0',
        left: '0',
        right: '0',
        background: 'rgba(29, 106, 154, 0.72)',
        color: '#fff',
        transition: 'opacity .2s, visibility .2s',
      }

      var hoverBoxStyle = {
        width: '75%',
        margin: '0 auto',
        position: 'relative'
      }

      var spanStyle = {
        float: 'right',
        color: 'green'
      }

      var colCentered = {
        display: 'inline-block',
        float: 'none',
        margin: '20px 0px 20px 0px'
      }

      return(
        <div style={colCentered} className="col-lg-4 col-md-4 col-sm-6 col-xs-12">
          <div className="base-title ">{product.name}{ this.hasProduct(product.uuid) ? <span style={spanStyle} className="glyphicon glyphicon-shopping-cart">{this.state[product.uuid]}</span> : null }</div>
          <div  className="base-container">
            <div onMouseEnter={()=> this.toggleShowDescription(product.uuid, true)} onMouseLeave={()=> this.toggleShowDescription(product.uuid, false)} style={hoverBoxStyle}>
               <img style={imageStyle} src={product.image_url}/> 
               { this.showDescription(product.uuid) ? <div style={descriptionStyle}>{product.description}</div> : null }
            </div>
            <h2>${product.price} / each</h2>
            <button style={buttonStyle} className="btn btn-danger" onClick={()=> this.add(product.uuid, -1) }>-</button>
            <button style={buttonStyle} className="btn btn-success" onClick={()=> this.add(product.uuid, 1) }>+</button>
          </div>
        </div>
      )
    })

    var centered = {
        textAlign: 'center'
      }

    return(
      <div style={centered} className="row">{products}</div>
    )
  }
}
