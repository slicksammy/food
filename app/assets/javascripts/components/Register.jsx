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
      success: function(result) {
        window.location = this.props.redirect_url
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
    return(this.state.password.match(/^(?=.*[a-zA-Z])(?=.*[0-9])/) ? true : false)
  }

  validEmail() {
    return(this.state.email.match(/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9][a-z0-9](?:[a-z0-9-]*[a-z0-9])?/) ? true : false)
  }



  /* IMPORTANT: need to add handle and email validation */
  
  render() {
    var buttonStyle = {
      float: 'left'
    }
    
    var complete_style = {
      borderRadius: '50%',
      background: '#f0f0f5',
      height: '30px',
      width: '30px',
      color: 'green',
      textAlign: 'center',
      padding: '5px',
      margin: '5px'
    }

    var incomplete_style = {
      color: 'black',
      background: 'grey',
      borderRadius: '50%',
      height: '10px',
      width: '10px',
      textAlign: 'center',
    }

    var inputStyle = {
      width: '85%',
      display: 'inline-block'
    }

    var firstNameStyle = this.validFirstName() ? complete_style : incomplete_style
    var lastNameStyle = this.validLastName() ? complete_style : incomplete_style
    var emailStyle = this.validEmail() ? complete_style : incomplete_style
    var passwordStyle = this.validPassword() ? complete_style : incomplete_style

    return(
      <div id="registerbox">
        <form id="register" className="col-xs-9">
          <div className="form-group">
            { this.state.errors.first_name ? <span className="create-user-error">{this.state.errors.first_name}</span> : null }
            <input style={inputStyle} onChange={this.updateState} type="text" className="form-control" ref="firstName" placeholder="First Name" id="firstName" /><span style={firstNameStyle} className="glyphicon glyphicon-ok"></span>
          </div>
          <div className="form-group">
            { this.state.errors.last_name ? <span className="create-user-error">{this.state.errors.last_name}</span> : null }
            <input style={inputStyle} onChange={this.updateState} type="text" className="form-control" placeholder="Last Name" id="lastName"/><span style={lastNameStyle} className="glyphicon glyphicon-ok"></span>
          </div>
          <div className="form-group">
            { this.state.errors.email ? <span className="create-user-error">{this.state.errors.email}</span> : null }
            <input style={inputStyle} onChange={this.updateState} type="text" className="form-control" placeholder="Email" id="email"/><span style={emailStyle} className="glyphicon glyphicon-ok"></span>
          </div>
          <div className="form-group">
            { this.state.errors.password ? <span className="create-user-error">{this.state.errors.password}</span> : null }
            <input style={inputStyle} onChange={this.updateState} type="password" className="form-control" placeholder="Password" id="password"/><span style={passwordStyle} className="glyphicon glyphicon-ok"></span>
          </div>
          <button disabled={!this.state.canSubmit} onClick={this.completeRegistration} ref="button" className="btn btn-success btn-submit" type="submit">Sign Up</button>
        </form>
      </div>
    )
  }
}

const TextOnly = /^[a-zA-Z]{3,}$/
