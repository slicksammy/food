class Payment extends React.Component {
  constructor() {
    super();
    this.state = {number: '', month: '', year: '', cvc: '', canSubmit: true};
    this.updateState = this.updateState.bind(this);
    this.canSubmit = this.canSubmit.bind(this);
    this.createPayment = this.createPayment.bind(this)
  }

  updateState(e) {
    this.setState(
      {[e.target.id]: e.target.value, canSubmit: true}
    )
  }

  createPayment() {
    this.setState({canSubmit: false})

    $.ajax({
      method: 'POST',
      url: '/stripe/create',
      data: { details: this.state },
      error: function() {
        this.setState({error: true, success: false})
      }.bind(this),
      success: function(response) {
        this.setState({success: true, error: false})
        this.props.onSuccess(response.uuid)
      }.bind(this)
    })
  }

  componentDidMount() {
    card.addEventListener('submit', function(event) {
      event.preventDefault() }
    )
  }

  componentDidUpdate() {
    if(this.state.canSubmit != this.canSubmit()) {
      this.setState({canSubmit: !this.state.canSubmit})
    }
  }

  canSubmit() {
    return(this.validNumber() && this.validMonth() && this.validYear() && this.validCvc() && this.state.canSubmit)
  }

  validNumber() {
    return(this.state.number.match(/^[0-9]{16}$/) ? true : false)
  }

  validMonth() {
    return(this.state.month.match(/^(0?[1-9]|1[012])$/) ? true : false)
  }

  validYear() {
    return(this.state.year.match(/^20(1[7-9]|2[0-6])$/) ? true : false)
  }

  validCvc() {
    return(this.state.cvc.match(/^[0-9]{3}$/) ? true : false)
  }

  render() {
    var buttonStyle = {
      float: 'left'
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
      width: '85%',
      display: 'inline-block'
    }

    var long = {
      width: '60%'
    }

    var short = {
      width: '20%'
    }

    var numberStyle = this.validNumber() ? complete_style : incomplete_style
    var monthStyle = this.validMonth() ? complete_style : incomplete_style
    var yearStyle = this.validYear() ? complete_style : incomplete_style
    var cvcStyle = this.validCvc() ? complete_style : incomplete_style

    return(
      <div>
        <div>
          <div className="base-title">New Credit Card</div>
        </div>
        <div className="base-container">
          <form id="card">
            {this.state.error ? <div>There was an error, please wait a few seconds and try again</div> : null }
            {this.state.success ? <Success message="congrats" wait="2000" /> : null }
            <div>
              <input className="base-input" style={long} id="number" onChange={this.updateState} placeholder="card number" type="text" /><span style={numberStyle} className="glyphicon glyphicon-ok"></span>
              <input className="base-input" style={short} onChange={this.updateState} id="cvc" placeholder="cvc" type="text" /><span style={cvcStyle} className="glyphicon glyphicon-ok"></span>
            </div>
             <div>
              <Months onChange={this.updateState} id="month"/><span style={monthStyle} className="glyphicon glyphicon-ok"></span>
              <Years onChange={this.updateState} id="year"/><span style={yearStyle} className="glyphicon glyphicon-ok"></span>
            </div>
            <div className="centered">
              <button className="btn btn-success base-button" disabled={!this.canSubmit()} onClick={this.createPayment} ref="button" type="submit">Save</button>
            </div>
          </form>
        </div>
      </div>
    )
  }
}

const Months = (props) => {
  return(
    <select className="base-input" id={props.id} onChange={props.onChange} style={props.selectStyle}>
      <option style={props.optionStyle}>Month</option>
      <option style={props.optionStyle} value="1">Jan</option>
      <option style={props.optionStyle} value="2">Feb</option>
      <option style={props.optionStyle} value="3">Mar</option>
      <option style={props.optionStyle} value="4">April</option>
      <option style={props.optionStyle} value="5">May</option>
      <option style={props.optionStyle} value="6">Jun</option>
      <option style={props.optionStyle} value="7">July</option>
      <option style={props.optionStyle} value="8">August</option>
      <option style={props.optionStyle} value="9">September</option>
      <option style={props.optionStyle} value="10">October</option>
      <option style={props.optionStyle} value="11">November</option>
      <option style={props.optionStyle} value="12">December</option>
    </select>
  )
}

const Years = (props) => {
  return(
    <select className="base-input" id={props.id} onChange={props.onChange} >
      <option>Year</option>
      <option value="2017">2017</option>
      <option value="2018">2018</option>
      <option value="2019">2019</option>
      <option value="2020">2020</option>
      <option value="2021">2021</option>
      <option value="2022">2022</option>
      <option value="2023">2023</option>
      <option value="2024">2024</option>
      <option value="2025">2025</option>
      <option value="2026">2026</option>
    </select>
  )
}
