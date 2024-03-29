class LoginSignup extends React.Component {
  constructor(props) {
    super(props);
    this.state = { show: props.show }
    this.toggle = this.toggle.bind(this)
  }

  toggle() {
    if(this.state.show == 'login') {
      this.setState({show: 'register'})
    } else {
      this.setState({show: 'login'})
    }
  }

  render() {
    var containerStyle = {
      textAlign: 'center',
      padding: '10px',
      width: '100%',
      margin: '0 auto'
    }

    var title = this.state.show == 'login' ? 'Login' : 'Create Account'

    var link = this.state.show == 'login' ? 'New user?' : 'Already have an account?'

    var a_style = {
      color: 'blue',
      textDecoration: 'none',
      cursor: 'pointer'
    }

    return(
      <div>
        <div className="base-title">{title}</div>
        <div className="base-container" style={containerStyle}>
          { this.state.show == 'login' ? <Login redirect_url={this.props.redirect_url} /> : <Register redirect_url={this.props.redirect_url}/> }
          <a style={a_style} onClick={this.toggle}>{link}</a>
        </div>
      </div>
    )
  }
}
