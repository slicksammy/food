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

    var tdStyle = {
      borderBottom: 'solid',
      padding: '10px 5px 10px 5px',
      width: '25%'
    }

    var items_2 = this.props.items.map( (item) => {
      var imageStyle = {
        width: '100px',
        height: '100px'
      }

      return(
        <tr>
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

    var noBorder = {
      borderBottom: 'none'
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
                <tr>
                  <th className="centered" style={{tdStyle,noBorder}}>Item</th>
                  <th className="centered" style={{tdStyle,noBorder}}>Description</th>
                  <th className="centered" style={{tdStyle,noBorder}}>Quantity</th>
                  <th className="centered" style={{tdStyle,noBorder}}>Subtotal</th>
                </tr>
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
