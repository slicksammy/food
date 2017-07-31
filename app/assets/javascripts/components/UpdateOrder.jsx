class UpdateOrder extends React.Component {
  constructor(props) {
    super(props);
    this.state = { selected: props.default, options: [] };
    this.update = this.update.bind(this);
    this.getOptions = this.getOptions.bind(this);
  }

  componentDidMount() {
    this.getOptions()
  }

  getOptions() {
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
      overflow: 'hidden'
    }

    var inputStyle = {
      marginRight: '0px'
    }

    var options = this.state.options.map( (option) => {
      var checked = this.state.selected == option.value
      return(<div style={divStyle}><input style={inputStyle} type="radio" checked={checked} onChange={()=>this.update(option.value)} value={option.value} /><span>{option.display}</span></div>)
    });

    var header_style = {
      width: '100%'
    }

    var containerStyle = {
      width: '100%'
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
