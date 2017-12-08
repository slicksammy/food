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
        if(this.props.onChange) {
          this.props.onChange()
        }
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
        maxWidth: '95%',
        maxHeight: '200px',
        minWidth: '280px'
      }

      var containerStyle = {
        textAlign: 'center',
        paddingTop: '10px',
        maxWidth: '100%'
      }

      var buttonStyle = {
        margin: '15px',
        fontSize: '20px',
        width: '40px',
        height: '40px'
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
        padding: '10px'
      }

      var hoverBoxStyle = {
        width: '75%',
        margin: '0 auto',
        position: 'relative'
      }

      var spanStyle = {
        // float: 'left',
        clear: 'both',
        fontSize: '30px',
        display: 'block',
        width: '25px',
        margin: '0 auto',
        marginTop: '-50px',
        marginBottom: '5px',
        color: '#02ff02',
      }

      var packageStyle = {
        // clear: 'both',
        // fontSize: '50px',
        // display: 'block',
        // width: '25px',
        // height: '100px',
        // margin: '0 auto',
        // marginTop: '-20px',
        // marginBottom: '30px',
        // width: '40px',
        // color: 'white',
        // fontWeight: 'bold',
        display: 'block',
        horizontalAlign: 'center',
        marginTop: '-40px'
      }

      var packagePadded = {
        padding: '20px'
      }

      var colCentered = {
        display: 'inline-block',
        float: 'none',
        margin: '20px 0px 20px 0px',
      }

      var margin = {
        margin: '-5px'
      }

      var restPrice = {
        textDecoration: 'line-through',
        color: '#d40766'
      }

      if (!this.hasProduct(product.uuid)  && !!this.props.hideOnZero) {
        return(null)
      }

      return(
        <div style={colCentered} className="col-lg-4 col-md-4 col-sm-6 col-xs-11">
          <div className="base-title-product"><strong>{product.name}</strong></div>
          <div  className="base-container-product">
            { this.props.showPackageTotals ?
              <div style={packageStyle}>
                <span>Quantity: {this.state[product.uuid]}</span>
              </div> : null 
            }
            <img style={imageStyle} className="img-rounded layer-shadow2" src={product.image_url}/> 
            { this.hasProduct(product.uuid) && this.props.showCartTotals ? <span style={spanStyle} className="glyphicon glyphicon-shopping-cart centered no-line">{this.state[product.uuid]}</span> : null }
            {/*<div onMouseEnter={()=> this.toggleShowDescription(product.uuid, true)} onMouseLeave={()=> this.toggleShowDescription(product.uuid, false)} style={hoverBoxStyle}>
              
               { this.showDescription(product.uuid) ? <div style={descriptionStyle}>{product.description}</div> : null }
            </div>*/}
            <h3>{product.description}</h3>
            <h3 style={restPrice}>regular price: ${product.regular_price}</h3>
            <h2>${product.price} ({product.regular_price_discount}% OFF)</h2>
            { !this.props.showButtons ? null :
              <div>
                <button style={buttonStyle} className="btn btn-success cart_update layer-shadow1 shop-background" onClick={()=> this.add(product.uuid, 1) } id="cart_add">+</button>
                <button style={buttonStyle} className="btn btn-danger cart_update layer-shadow1 red" onClick={()=> this.add(product.uuid, -1) } id="cart_subtract">-</button>
              </div>
            }
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
