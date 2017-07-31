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

    var items_2 = this.props.items.map( (item) => {
      var imageStyle = {
        width: '100px',
        height: '100px'
      }

      var trStyle = {
        
      }

      var tdStyle = {
        borderBottom: 'solid',
        padding: '10px 5px 10px 5px',
        width: '25%'
      }


      return(
        <tr style={trStyle}>
          <td style={tdStyle}>
            <div style={{clear: 'both'}}>{item.name}</div>
            <img style={imageStyle} src={item.image} />
          </td>
          <td style={tdStyle}>
            {item.description}
          </td>
          <td style={tdStyle}>
            {item.amount}
          </td>
          <td style={tdStyle}>
            ${item.total}
          </td>
        </tr>
      )
    })

    var tableStyle = {
      width: '100%'
    }

    var totalStyle = {
      fontSize: '3vw'
    }

    return(
     <div>
        <div>
          <div className="base-title">Order Summary</div>
        </div>
        <div className="base-container centered">
          <div>
            <table style={tableStyle}>
              <tbody>
                {items_2}
              </tbody>
            </table>
          </div>
          <div style={totalStyle}>Subtotal: ${this.props.order.subtotal}</div>
          <div style={totalStyle}>Tax: ${this.props.order.tax}</div>
          <div style={totalStyle}>Shipping: ${this.props.order.shipping}</div>
          <div style={totalStyle}>Total: ${this.props.order.total}</div>
        </div>
        {/*<button onClick={this.order}>Buy</button>*/}
      </div>
    )
  }
}

const ProductsTable = (props) => {
  return(
    <table>
      
    </table>
  )
}
