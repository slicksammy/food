class Search extends React.Component {
  constructor() {
    super();
    this.state = { notes: [] }
    this.search = this.search.bind(this)
  }

  search() {
    var search = this.refs.search.value

    $.ajax({
      method: 'GET',
      url: '/search',
      data: { search: search },
      success: function(response) {
        this.setState({notes: response.notes})
        //this.setState({ notes: response.json.notes })
      }.bind(this)
    })
  }

  render() {
    var notes = this.state.notes.map( (note)=>{
      var href = '/places/' + note.place_id
      return (
        <div>
          <a href={href}><h4>{note.name}</h4></a>
          <p>{note.text}</p>
        </div>
      )
    })

    return(
      <div>
        <input type="text" ref="search" />
        <button onClick={this.search}>Search</button>
        { notes ? notes : null }
      </div>
    )
  }
}
