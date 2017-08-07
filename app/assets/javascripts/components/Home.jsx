class Home extends React.Component {
  constructor() {
    super();
  }

  render() {

    var margin = {
      margin: '20px 0px 20px 0px'
    }

    var orders = this.props.orders.map( order => {
      return(<div style={margin} ><Order order={order.order} items={order.items} /></div>)
    })

    return(
      <div>
        {orders}
      </div>
    )
  }
}
