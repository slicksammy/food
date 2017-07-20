// very similar to ChoosePayment
class ChooseAddress extends React.Component {
  constructor() {
    super();
    this.state = {}
    this.updateCard = this.updateCard.bind(this)
  }

  componentWillMount() {
    var payment = this.props.options.find( function(a) { return a.active } )
    this.setState({ activeCard: payment.id})
  }

  updateCard(id) {
    $.ajax({
      method: 'POST',
      url: 'payment/update',
      data: { id: id},
      success: this.setState({activeCard: id})
    })
  }

  render() {
    var payments = this.props.options.map( (payment) => {
      var checked = (this.state.activeCard == payment.id)
      return(<div><input type="radio" checked={checked} onChange={()=>this.updateCard(payment.id)} value={payment.id} /><span>card ending in {payment.last_4}</span></div>)
    });

    return(
      <div id="choose-payment">
        {payments}
      </div>
    )
  }
}
