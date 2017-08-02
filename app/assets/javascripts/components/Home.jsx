class Home extends React.Component {
  constructor() {
    super();
  }

  render() {
    var orders = this.props.orders.map( order => {
      console.log(order)
      return(<Order order={order.order} items={order.items} />)
    })

    return(
      <div>
        {orders}
      </div>
    )
  }
}
