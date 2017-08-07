class Login extends React.Component {
  constructor() {
    super();
    this.state = {};
    this.updateState = this.updateState.bind(this);
    this.canSubmit = this.canSubmit.bind(this);
    this.login = this.login.bind(this)
  }

  componentDidMount() {
    login.addEventListener('submit', function(event) {
      event.preventDefault() }
    )
  }

  updateState(e) {
    this.setState(
      {[e.target.id]: e.target.value, error: null}
    )
  }

  login() {
    $.ajax({
      method: 'POST',
      url: '/sessions/new',
      data: { email: this.state.email, password: this.state.password },
      success: function(response) {
        console.log(this.props.redirect_url)
        window.location = this.props.redirect_url || response.redirectUrl
      }.bind(this),
      error: function(response) {
        this.setState({error: response.responseJSON.error})
      }.bind(this)
    })
  }


  componentDidUpdate() {
    if(this.state.canSubmit != this.canSubmit()) {
      this.setState({canSubmit: !this.state.canSubmit})
    }
  }

  canSubmit() {
    return(!!this.state.email && !!this.state.password && !this.state.error)
  }

  render() {
    var inputStyle = {
      width: '75%',
      display: 'inline-block',
    }

    var buttonStyle = {
      width: '75%'
    }

    return(
      <form id="login">
        {this.state.error ? <p>{this.state.error}</p> : null }
        <div>
          <input style={inputStyle} onChange={this.updateState} type="text" className="base-input" ref="firstName" placeholder="Email" id="email" />
        </div>
        <div>
          <input style={inputStyle} onChange={this.updateState} type="password" className="base-input" placeholder="Password" id="password"/>
        </div>
        <button style={buttonStyle} disabled={!this.state.canSubmit} onClick={this.login} ref="button" className="btn btn-success btn-submit" type="submit">Login</button>
      </form>
    )
  }
}
