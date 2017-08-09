class ResetPassword extends React.Component {
  constructor(props) {
    super(props);
    this.state = {password: '', confirm: '', token: props.token};
    this.validPassword = this.validPassword.bind(this);
    this.updateState = this.updateState.bind(this);
    this.validConfirm = this.validConfirm.bind(this);
    this.canSubmit = this.canSubmit.bind(this);
    this.resetPassword = this.resetPassword.bind(this)
  }

  updateState(e) {
    this.setState(
      {[e.target.id]: e.target.value}
    )
  }

  validPassword() {
    return(this.state.password.match(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.{6,})/) ? true : false)
  }

  validConfirm() {
    return(!!this.state.confirm && this.state.password == this.state.confirm)
  }

  canSubmit() {
    return(this.validPassword() && this.validConfirm())
  }

  componentDidUpdate() {
    if(this.state.canSubmit != this.canSubmit()) {
      this.setState({canSubmit: !this.state.canSubmit})
    }
  }

  resetPassword() {
    $.ajax({
      method: 'POST',
      url: '/reset_password',
      data: this.state,
      // success: function(response) {
      //   window.location = '/'
      // }
    })
  }

  render() {
    var labelStyle = {
      fontSize: 'medium'
    }

    var inputStyle = {
      width: '75%',
      display: 'inline-block',
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

    var containerStyle = {
      textAlign: 'center',
      padding: '10px',
      width: '100%',
      margin: '0 auto'
    }

    var passwordStyle = this.validPassword() ? complete_style : incomplete_style
    var confirmStyle = this.validConfirm() ? complete_style : incomplete_style

    var buttonStyle = {
      width: '65%'
    }

    return(
      <div>
        <div className="base-title">Reset Password</div>
        <div className="base-container" style={containerStyle}>
          <label style={labelStyle}>password must include one letter, one number and be at least 6 characters long</label>
          <input style={inputStyle} onChange={this.updateState} type="password" className="base-input" placeholder="Password" id="password"/><span style={passwordStyle} className="glyphicon glyphicon-ok"></span>
          <input style={inputStyle} onChange={this.updateState} type="password" className="base-input" placeholder="Confirm Password" id="confirm"/><span style={confirmStyle} className="glyphicon glyphicon-ok"></span>
          <div>
            <button style={buttonStyle} disabled={!this.state.canSubmit} onClick={this.resetPassword} ref="button" className="btn btn-success btn-submit" type="submit">Reset Password</button>
          </div>
        </div>
      </div>
    )
  }
}
