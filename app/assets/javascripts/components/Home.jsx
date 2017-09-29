class Home extends React.Component {
  constructor() {
    super();
  }

  render() {

    var margin = {
      margin: '20px 0px 20px 0px'
    }

    var orders = this.props.orders.map( order => {
      return(
        <div style={margin} >
          <h2>Status: {order.order.status}</h2>
          { order.order.delivered_on ? <h2>Delivered on: {order.order.delivered_on}</h2> : <h2>Order will arrive on {order.order.formatted_expected_delivery_date}</h2> }
          <Order order={order.order} items={order.items} />
        </div>
      )
    })

    return(
      <div>
        { orders ? <h1>No orders yet, let's <a href="/#store">shop!</a></h1> : {orders} }
      </div>
    )
  }
}
