class Place extends React.Component {
  constructor(props) {
    super(props);
    this.state = { notes: props.notes, status: props.status}
    this.saveNote = this.saveNote.bind(this)
    this.updateStatus = this.updateStatus.bind(this)
    console.log(props)
  }


  saveNote() {
    var text = this.refs.text.value
    var id = this.props.place.id

    $.ajax({
      method: "POST",
      url: '/places/' + id + '/notes',
      data: {text: text}
    });

    // this.state.notes.splice(0, {note_text: text, created_at: 'NOW'});

    // this.forceUpdate();

    var notes = [{note_text: text, created_at: 'Now'}].concat(this.state.notes)

    this.setState({notes: notes })
    this.refs.text.value = ''
  };

  updateStatus(e) {
    var status = e.target.value
    var id = this.props.place.id

    $.ajax({
      method: "POST",
      url: '/places/' + id + '/update_status',
      data: {status: status}
    });

    this.setState({status: status})
  };

  render() {
    var places = this.props.data.map( (place) => {
      return(<p>{place[0]} : {place [1]}</p>)
    });

    var notes = this.state.notes.map( (note) => {
      return(
          <tr>
            <td>{note.created_at}</td>
            <td>{note.note_text}</td>
          </tr>
      )
    });

    var action = '/places/' + this.props.place.id + '/notes'

    var statuses = this.props.statuses.map( (status) => {
      return(<option value={status.id}>{status.status}</option>)
    })

    var defaultStatus = this.state.status ? this.state.status.id : '0'

    console.log(defaultStatus)

    return(
      <div>
        {/*<Callback id={this.props.place.id} />*/}
        <h1>{this.props.place.name}</h1>
        <h3>Status: <select value={defaultStatus} onChange={this.updateStatus}><option disabled value='0'>no status</option>{statuses}</select></h3>
        <h2>{this.props.place.phone_number}</h2>
        <h2>{this.props.place.address}</h2>
        <div>
          {places}
        </div>
        <div>
          <h2>Notes</h2>
          <table>
            <tbody>
              <tr>
                <td>Created At</td>
                <td>Text</td>
              </tr>
              {notes}
            </tbody>
          </table>
          <textarea columns="40" rows="5" ref="text"></textarea>
          <button onClick={this.saveNote} type="submit">Save</button>
        </div>
        <div>
          <h2>VM Script</h2>
          <p>Hi (PERSONS NAME), this is Sam calling from Brokolly - a new grocery delivery startup serving downtown Chicago. We're an affordable
          and convenient way for tenants to order groceries online and have them delivered, cutting out the hassle of walking to the store, waiting in line,
          and carrying heavy groceries home. I was hoping I could have 2-3 minutes of your time to discuss the opportunity. Please give me a call back at your convenience at 312-523-7986. Thank you.
          </p>
        </div>
      </div>
    )
  }
}
