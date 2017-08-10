class UpdateOrder extends React.Component {
  constructor(props) {
    super(props);
    this.state = { selected: props.default, options: this.props.options || [] };
    this.update = this.update.bind(this);
    this.getOptions = this.getOptions.bind(this);
  }

  componentDidMount() {
    this.getOptions()
  }

  getOptions() {
    if (this.props.options) { return }
      
    $.ajax({
      method: 'GET',
      url: this.props.optionsUrl,
      success: function(response) {
        this.setState({options: response.options})
      }.bind(this)
    });
  }

  componentWillReceiveProps(props) {
    this.setState({selected: props.default})
    this.getOptions()
  }

  update(val) {
    this.props.onUpdate(val);
    this.setState({selected: val})
  }

  render() {
    if(!this.props.default) { return(null) }

    var divStyle = {
      margin: '20px',
      display: 'block',
      overflow: 'hidden',
      padding: '10px'
    }

    var spanStyle = {
      marginLeft: '10px'
    }

    var options = this.state.options.map( (option) => {
      var checked = this.state.selected == option.value
      console.log(this.state.selected)
      console.log(option.value)
      return(<div style={divStyle}><input type="radio" checked={checked} onChange={()=>this.update(option.value)} value={option.value} /><span style={spanStyle}>{option.display}</span></div>)
    });

    var header_style = {
      width: '100%'
    }

    var containerStyle = {
      width: '100%',
      textAlign: 'left'
    }

    return(
      <div>
        <div>
          <div style={header_style} className='base-title'>{this.props.title}</div>
        </div>
        <div style={containerStyle} className='base-container'>
          {options}
        </div>
      </div>
    )
  }
}
