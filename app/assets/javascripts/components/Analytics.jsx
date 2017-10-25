class Analytics extends React.Component {
  render() {
    var views = Object.keys(this.props.pageVisits).map( (key, index) => {

      var pages = this.props.pageVisits[key].map( url => {
        return(<li>{url}</li>)
      })

      return(<ul>
        <h2>{key}</h2>
        {pages}
      </ul>)
    })

    return(
      <div>
        {views}
      </div>
    )
  }
}
