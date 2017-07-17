class NewPlace extends React.Component {
  constructor() {
    super();
  }

  render() {
    var types = this.props.types.map( (type) => {
      return(<option value={type.id}>{type.description}</option>)
    })

    return(
      <div>
        <h2>Create New Place</h2>
        <form method="POST">
          <input type="text" placeholder="name" name="name"/>
          <input type="text" placeholder="address" name="address"/>
          <input type="text" placeholder="phone" name="phone"/>
          <select required name="place_type">{types}</select>
          <textarea cols="40" rows="4" placeholder="note" name="note"/>
          <button type="submit">Submit</button>
        </form>
      </div>
    )
  }
}
