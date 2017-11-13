class NewPlace extends React.Component {
  constructor() {
    super();
  }

  render() {
    var types = this.props.types.map( (type) => {
      return(<option value={type.id}>{type.description}</option>)
    })

    var inputStyle = { display: 'block'}

    return(
      <div>
        <h2>Create New Place</h2>
        <form method="POST">
          <input style={inputStyle} type="text" placeholder="name" name="name"/>
          <input style={inputStyle}type="text" placeholder="address" name="address"/>
          <input style={inputStyle}type="text" placeholder="phone" name="phone"/>
          <select style={inputStyle} required name="place_type">{types}</select>
          <textarea style={inputStyle} cols="40" rows="4" placeholder="note" name="note"/>
          <button style={inputStyle} type="submit">Submit</button>
        </form>
      </div>
    )
  }
}
