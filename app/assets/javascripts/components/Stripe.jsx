class Stripe extends React.Component {
  constructor() {
    super();
  }
  render() {
    return(
      <div>
        <form action="/charge" method="post" id="payment-form">
          <div className="form-row">
            <label htmlFor="card-element">
              Credit or debit card
            </label>
            <div id="card-element">
              
            </div>

            
            <div id="card-errors" role="alert"></div>
          </div>

          <button>Submit Payment</button>
        </form>
        <script src="https://js.stripe.com/v3/"></script>
      </div>
    )
  }
}
