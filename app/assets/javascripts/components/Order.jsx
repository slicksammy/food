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
      borderBottom: '1 px solid',
      padding: '10px 5px 10px 5px',
      width: '25%',
      fontSize: '24px'
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
            {/*<img style={imageStyle} src={item.image} />*/}
          </td>
          {/*<td style={tdStyle}>
            {item.description}
          </td>*/}
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
      fontSize: '24px',
      display: 'block',
      width: '70%',
      margin: '0 auto'
    }

    var noBorder = {
      borderBottom: 'none'
    }

    var borderTop = {
      borderTop: 'solid 1px',
      display: 'block',
      marginBottom: '10px'
    }

    var instructionsStyle = {
      fontSize: '30px',
      float: 'left',
      display: 'block',
      marginTop: '20px'
    }

    return(
     <div>
        <div>
          <div className="base-title">Order Summary #{this.props.order.order_number}</div>
        </div>
        <div className="base-container centered">
          <div>
            <table style={tableStyle}>
              <tbody>
                <tr>
                  <th className="centered" style={tdStyle}>Item</th>
                  {/*<th className="centered" style={{tdStyle,noBorder}}>Description</th>*/}
                  <th className="centered" style={tdStyle}>Quantity</th>
                  <th className="centered" style={tdStyle}>Subtotal</th>
                </tr>
                {items_2}
              </tbody>
            </table>
          </div>
          <span style={borderTop}></span>
          <div style={totalStyle} className="row"><span className="left-float">Subtotal</span><span className="right-float">${this.props.order.subtotal}</span></div>
          {this.props.order.discount ? <div style={totalStyle} className="row"><span className="left-float">Discount</span><span className="right-float">-${this.props.order.discount}</span></div> : null }
          <div style={totalStyle} className="row"><span className="left-float">Tax</span><span className="right-float">${this.props.order.tax}</span></div>
          <div style={totalStyle} className="row"><span className="left-float">Shipping</span><span className="right-float">${this.props.order.shipping}</span></div>
          <div style={totalStyle} className="row"><span className="left-float">Total</span><span className="right-float">${this.props.order.total}</span></div>
          { this.props.order.instructions ? <p style={instructionsStyle}>Instructions: {this.props.order.instructions}</p> : null }
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
