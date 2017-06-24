class NewPlace extends React.Component {
  construct() {
    this.submit = this.submit.bind(this)
  }

  submit(e) {
    console.log(e.target.value)
    // $.ajax({
    //   type: "POST",
    //   url: 'places/new',
    //   data: {}
    // })
  }

  render() {
    return(
      <div>
        <h2>Create New Place</h2>
        <form method="POST">
          <input type="text" placeholder="name" name="name"/>
          <input type="text" placeholder="address" name="address"/>
          <input type="text" placeholder="phone" name="phone"/>
          <input type="text" placeholder="internal type" name="internal_type"/>
          <textarea cols="40" rows="4" placeholder="note" name="note"/>
          <button type="submit">Submit</button>
        </form>
      </div>
    )
  }
}
