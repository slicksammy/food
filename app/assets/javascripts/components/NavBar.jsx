class NavBar extends React.Component {
  constructor() {
    super();
    this.state = {};
    this.getCount = this.getCount.bind(this);
  }

  componentDidMount() {
    this.getCount()
  }

  getCount() {
    $.ajax({
      method: 'GET',
      url: '/cart/count',
      success: function(response) {
        this.setState({cart: response.count})
      }.bind(this)
    })
  }

  render() {
    var navStyle = {
      borderRadius: '0px',
    }

    var aStyle = {
      fontSize: '40px'
    }

    var floatRight = {
      float: 'right'
    }

    var greenColor = {
      color: 'green'
    }

    var brandStyle = {
      width: '20%'
    }

    var bigFont = {
      fontSize: '40px',
      backgroundColor: 'red',
      color: 'white'
    }

    var containerStyle = {
      fontSize: '40px',
      backgroundColor: 'red',
      color: 'white'
    }

    var noBorder = {
      borderTop: 'none',
    }

    var padded = {
      paddingBottom: '15px'
    }

    return(
      <nav className="navbar navbar-default" style={navStyle}>
        <div style={bigFont} className="container-fluid">
          <div style={padded} className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a style={bigFont} href="/store" className="navbar-brand">I<span className="glyphicon glyphicon-heart"></span>Meat</a>
          </div>
          <div style={noBorder} className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav">
              <li><a style={bigFont} href="/cart"><span className="glyphicon glyphicon-shopping-cart">{this.state.cart > 0 ? this.state.cart : null }</span></a></li>
              <li><a style={bigFont} href="/about"><span className="glyphicon">About</span></a></li>
              <li><a style={bigFont} href="/availability"><span className="glyphicon">Availability</span></a></li>
              { this.props.signedIn? <li><a style={bigFont} href="/home"><span className="glyphicon">Home</span></a></li> : null }
              { this.props.signedIn? <li><a style={bigFont} href="/logout"><span className="glyphicon">Logout</span></a></li> : <li><a style={bigFont} href="/login"><span className="glyphicon">Login</span></a></li> }
            </ul>
          </div>
        </div>
      </nav>
    )
  }
}
