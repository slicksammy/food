class Register extends React.Component {
  constructor() {
    super();
    this.state = {
      errors: {},
      email: '',
      password: '',
      lastName: '',
      firstName: ''
    }
    this.completeRegistration = this.completeRegistration.bind(this)
    this.updateState = this.updateState.bind(this)
    this.canSubmit = this.canSubmit.bind(this)
    this.validFirstName = this.validFirstName.bind(this)
    this.validLastName = this.validLastName.bind(this)
  }

  componentDidMount() {
    register.addEventListener('submit', function(event) {
      event.preventDefault() }
    )
  }

  componentDidUpdate() {
    if(this.state.canSubmit != this.canSubmit()) {
      this.setState({canSubmit: !this.state.canSubmit})
    }
  }

  completeRegistration () {
    var params = {
      firstName: this.state.firstName,
      lastName: this.state.lastName,
      email: this.state.email,
      password: this.state.password
    };

    $.ajax({
      type: "POST",
      url: 'users/create',
      data: params,
      success: function(response) {
        window.location = this.props.redirect_url || response.redirectUrl
      }.bind(this),
      error: function(result) {
        this.setState({
          errors: result.responseJSON.errors
        })
      }.bind(this)
    });
  }

  updateState(e) {
    this.setState(
      {[e.target.id]: e.target.value}
    )
  }

  canSubmit() {
    return(this.validFirstName() && this.validLastName() && this.validEmail() && this.validPassword())
  }

  validFirstName() {
    return(this.state.firstName.match(TextOnly) ? true : false)
  }

  validLastName() {
    return(this.state.lastName.match(TextOnly) ? true : false)
  }

  validPassword() {
    return(this.state.password.match(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.{6,})/) ? true : false)
  }

  validEmail() {
    return(this.state.email.match(/[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9][a-z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?/) ? true : false)
  }



  /* IMPORTANT: need to add handle and email validation */
  
  render() {
    var buttonStyle = {
      width: '65%',
    }
    
    var complete_style = {
      height: '10px',
      width: '10px',
      color: 'green',
      padding: '5px',
      marginRight: '10px'
    }

    var incomplete_style = {
      color: 'grey',
      height: '10px',
      width: '10px',
      marginRight: '10px',
    }

    var inputStyle = {
      width: '75%',
      display: 'inline-block',
    }

    var firstNameStyle = this.validFirstName() ? complete_style : incomplete_style
    var lastNameStyle = this.validLastName() ? complete_style : incomplete_style
    var emailStyle = this.validEmail() ? complete_style : incomplete_style
    var passwordStyle = this.validPassword() ? complete_style : incomplete_style

    var containerStyle = {
      textAlign: 'center',
      padding: '10px',
      width: '100%',
      margin: '0 auto'
    }

    return(
      <form id="register">
        <div>
          { this.state.errors.first_name ? <span className="create-user-error">{this.state.errors.first_name}</span> : null }
          <input style={inputStyle} onChange={this.updateState} type="text" className="base-input" ref="firstName" placeholder="First Name" id="firstName" /><span style={firstNameStyle} className="glyphicon glyphicon-ok"></span>
        </div>
        <div>
          { this.state.errors.last_name ? <span className="create-user-error">{this.state.errors.last_name}</span> : null }
          <input style={inputStyle} onChange={this.updateState} type="text" className="base-input" placeholder="Last Name" id="lastName"/><span style={lastNameStyle} className="glyphicon glyphicon-ok"></span>
        </div>
        <div>
          { this.state.errors.email ? <span className="create-user-error">{this.state.errors.email}</span> : null }
          <input style={inputStyle} onChange={this.updateState} type="text" className="base-input" placeholder="Email" id="email"/><span style={emailStyle} className="glyphicon glyphicon-ok"></span>
        </div>
        <div>
          { this.state.errors.password ? <span className="create-user-error">{this.state.errors.password}</span> : null }
          <input style={inputStyle} onChange={this.updateState} type="password" className="base-input" placeholder="Password" id="password"/><span style={passwordStyle} className="glyphicon glyphicon-ok"></span>
        </div>
        <button style={buttonStyle} disabled={!this.state.canSubmit} onClick={this.completeRegistration} ref="button" className="btn btn-success btn-submit" type="submit">Sign Up</button>
      </form>
    )
  }
}

const TextOnly = /^[a-zA-Z]{3,}$/
