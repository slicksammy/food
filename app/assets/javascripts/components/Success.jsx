class Success extends React.Component {
  constructor() {
    super();
    this.state = { show: true };
    this.hide = this.hide.bind(this)
  }

  componentDidMount() {
    setTimeout(this.hide, this.props.wait)
  }

  hide() {
    this.setState({show:false})
  }

  render() {
    if(!this.state.show) { return(null) }

    return(<div style={this.props.style}>{this.props.message}</div>)
  }
}
