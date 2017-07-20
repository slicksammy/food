class UpdateOrder extends React.Component {
  constructor(props) {
    super(props);
    this.state = { selected: props.options[0].id }
    this.update = this.update.bind(this)
  }

  update(id) {
    var param = {
      [this.props.param]: id
    }

    $.ajax({
      method: 'POST',
      url: 'order/update',
      data: { order: param},
      success: this.setState({selected: id})
    })
  }

  render() {
    var payments = this.props.options.map( (option) => {
      var checked = (this.state.selected == option.id)
      return(<div><input type="radio" checked={checked} onChange={()=>this.update(option.id)} value={option.id} /><span>{option.display}</span></div>)
    });

    return(
      <div>
        <h1>{this.props.title}</h1>
        {payments}
      </div>
    )
  }
}
