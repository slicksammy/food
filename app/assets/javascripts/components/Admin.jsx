class Admin extends React.Component {
  constructor() {
    super();
    this.state = {}
    this.canDeliver = this.canDeliver.bind(this);
    this.enableDelivery = this.enableDelivery.bind(this);
    this.divRef = this.divRef.bind(this);
    this.checkboxRef = this.checkboxRef.bind(this);
    this.noteRef = this.noteRef.bind(this);
    this.deliver = this.deliver.bind(this);
    this.buttonRef = this.buttonRef.bind(this)
  }

  canDeliver(uuid) {
    return(!!this.state[uuid])
  }

  enableDelivery(uuid) {
    this.setState({[uuid]: this.refs[this.checkboxRef(uuid)].checked})
  }

  divRef(uuid) {
    return("div_"+uuid)
  }

  checkboxRef(uuid) {
    return("checkbox_"+ uuid)
  }

  noteRef(uuid) {
    return("note_" + uuid)
  }

  buttonRef(uuid) {
    return("button_" + uuid)
  }

  deliver(uuid) {
    this.refs[this.buttonRef(uuid)].disabled = true

    $.ajax({
      method: 'POST',
      url: '/admin/deliver_order',
      data: { uuid: uuid, note: this.refs[this.noteRef(uuid)].value },
      success: function(response) {
        this.refs[this.divRef(uuid)].hidden = true
      }.bind(this)
    })
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
      var common = {
        display: 'block',
        marginTop: '20px'
      }

      var textAreaStyle = Object.assign(
        {
          width: '600px',
        }, common
      )

      var labelStyle = {
        // marginLeft: '10px',
        fontSize: '14px'
      }

      var checkboxStyle = Object.assign(
        {
          // width: '40px',
          // height: '40px'
          transform: 'scale(2)',
          marginRight: '10px',
          display: 'inline-block',
          marginTop: common['marginTop']
        }
      )

      var buttonStyle = Object.assign(
        common, {
          height: '40px',
          width: '60px'
        }
      )

      return(
        <div>
          <h3>Name: {order.name}</h3>
          <h3>Status: {order.status}</h3>
          <h3>Delivery Date: {order.order.formatted_expected_delivery_date}</h3>
          <Order order={order.order} items={order.items} />
          { !order.order.delivered_on ? 
            <div ref={this.divRef(order.uuid)}>
              <input style={checkboxStyle} ref={this.checkboxRef(order.uuid)} type="checkbox" onChange={()=>this.enableDelivery(order.uuid)}/>
              <label style={labelStyle}>Delivered</label>
              <textarea style={textAreaStyle} ref={this.noteRef(order.uuid)} placeholder="Leave the customer a note upon delivery (ie I left it at the front desk)"></textarea>
              <button ref={this.buttonRef(order.uuid)} style={buttonStyle} disabled={!this.canDeliver(order.uuid)} onClick={()=> this.deliver(order.uuid)}>Deliver!</button>
            </div> : null 
          }
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
