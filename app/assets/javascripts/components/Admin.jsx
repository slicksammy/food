class Admin extends React.Component {
  constructor() {
    super();
  }

  render() {
    var orders = this.props.orders.map( order=> {
      return(
        <tr>
          <td>{order.expected_delivery_date}</td>
        </tr>
      )
    })

    var headers = (
      <tr>
        <th>Expected Delivery Date</th>
      </tr>
    )

    var orders = this.props.orders.map( order => {
      return(
        <div>
          <h3>Name: {order.name}</h3>
          <h3>Status: {order.status}</h3>
          <h3>Delivery Date: {order.order.formatted_expected_delivery_date}</h3>
          <Order order={order.order} items={order.items} />
        </div>
      )
    })

    return(
      <div> 
        {orders}
      </div>
    )
  }
}
