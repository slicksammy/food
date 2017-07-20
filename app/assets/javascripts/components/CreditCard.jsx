// this form collects CC data
// makes an API call to strip
// makes a backend API call to save Stripe's response
// on success redirect customer to wherever they should go

class CreditCard extends React.Component {
  constructor() {
    super()
    this.state = {}
    this.stripeCall = this.stripeCall.bind(this)
    this.saveStripe = this.saveStripe.bind(this)
  }

  stripeCall() {
    // ajax post
  }

  saveStripe() {
    // save data from stripe api call
  }

  proceed() {
    // this should be passed in as props or you can receive it from the response in saveStripe
    window.location = '/submit'
  }

  render() {
    let months = Array.from(new Array(12), (x,i) => i + 1).map( (date) => {
      return(<option>{date}</option>)
    })

    let years = Array.from(new Array(10), (x,i) => i + 2017).map( (date) => {
      return(<option>{date}</option>)
    })

    return(
      <div id="credit-card">
        <link rel="stylesheet" type="text/css" href="assets/payment.css" />
        <input placeholder='card number' />
        <select>
          {months}
        </select>
        <select>
          {years}
        </select>
        <input placeholder='security code'/>
        <button>Save</button>
      </div>
    )
  }
}
