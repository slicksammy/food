class Places extends React.Component {
  constructor(props) {
    super(props);
    this.state = { type: 'all', data: props.data };
    // this.get = this.get.bind(this);
    this.updateTypes = this.updateTypes.bind(this);
    this.map = this.map.bind(this);
    this.updateType = this.updateType.bind(this)
  }

  // get() {
  //   $.ajax({
  //     url: '/places'
  //     success: function(response) {
  //       this.setState({data: response.data})
  //     }
  //   })
  // }

  // componentDidMount() {
  //   this.get()
  // }

  updateTypes() {
    var val = this.refs.type.value
    this.setState({ type: val})
  }

  map(places) {
    var selectedData = (this.state.type == 'all') ? places : (places.filter( function(a) { return a.place_type_id == this.state.type}.bind(this) ))

    var data = selectedData.map((p) => {
      var href = '/places/' + p.id
      return(
        <li><a target="_blank" href={href}>{p.name}</a></li>
      )
    })

    return data
  };

  updateType(e) {
    var val = e.target.value

    this.setState({type: val})
  }

  render() {
    console.log("heeeee")
    var places = this.map(this.state.data.places)

    var types = this.state.data.types.map( (type) => {
      return(<option value={type.id}>{type.description}</option>)
    });

    return (
      <div>
        <select ref="type" onChange={this.updateType}><option value="all">all</option>{types}</select>
        {places}
      </div>
    )
  }
}
