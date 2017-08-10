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

    console.log(this.props.orders)

    var orders = this.props.orders.map( order => {
      return(
        <div>
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
