class Callback extends React.Component {
  constructor() {
    super();
    this.state = {}
    this.getInfo = this.getInfo.bind(this)
  }

  getInfo() {
    var id = this.props.id

    $.ajax({
      method: "GET",
      url: '/places/' + id + '/callbacks',
      success: function(response) {
        this.setState({callbacks: response.callbacks})
      }.bind(this)
    });
  }

  componentDidMount() {
    this.getInfo()
  }

  render() {
    var callbacks = this.state.callbacks ? 
      this.state.callbacks.map((callback) => {
        return(<input type="date" value={callback.call_back_date} />)
      }) : 'No Callbacks'

    return(
      <div>
        {callbacks}
      </div>
    )
  }
}
