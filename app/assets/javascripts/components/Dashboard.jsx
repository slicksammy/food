class Dashboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = { stats: props.stats};
    this.getStats = this.getStats.bind(this)
  }

  getStats() {
    var time = input.value

    $.ajax({
      method: 'GET',
      url: '/admin/get_stats',
      data: { time: time},
      success: function(response) {
        this.setState({stats: response.stats})
      }.bind(this)
    })
  }

  render() {
    return(
      <div>
        <input id="input" />
        <button onClick={this.getStats}>Search</button>
        <h1>Orders: {this.state.stats.orders}</h1>
        <h1>Carts: {this.state.stats.carts}</h1>
        <h1>Users: {this.state.stats.users}</h1>
        <h1>Page Views: {this.state.stats.page_views}</h1>
        <h1>Unique Visitors: {this.state.stats.unique_visitors}</h1>
      </div>
    )
  }
}
