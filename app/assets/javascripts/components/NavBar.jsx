class NavBar extends React.Component {
  constructor() {
    super();
    this.state = {};
    this.getCount = this.getCount.bind(this);
  }

  componentWillMount() {
    $(document).ready(function(){
        $(".cart_update").click(function(){
            setTimeout(function() {this.getCount()}.bind(this), 500)
        }.bind(this));
    }.bind(this));
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
      // borderRadius: '0px',
    }

    var aStyle = {
      // fontSize: '40px'
    }

    var floatRight = {
      // float: 'right'
    }

    var greenColor = {
      // color: 'green'
    }

    var brandStyle = {
      // width: '20%'
    }

    var bigFont = {
      // fontSize: '24px',
      // color: '#FCFCFC'
    }

    var header = {
      // fontSize: '27px',
      // // color: '#FCFCFC',
      // // width: '30%',
      // marginRight: '40px',
      // marginTop: '-8px'
    }

    var noBorder = {
      // borderTop: 'none'
    }

    var padded = {
      // paddingBottom: '15px'
    }

    var ulStyle = {
      // width: '70%',
      // textAlign: 'center'
    }

    var ilStyle = {
      // width: '20%',
    }

    var red = {
      // color: 'red'
    }

    var img = {
      width: '75px'
    }

    return(
      <nav className="navbar navbar-toggleable-md navbar-light bg-faded navbar-fixed-top navbar-default" style={navStyle}>
        <div style={bigFont} className="container-fluid">
          <div style={padded} className="navbar-header">
            <button type="button" className="navbar-toggle navbar-toggler-right" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a style={header} href="/" className="navbar-brand"><img style={img} src="assets/logo_simple.png" /></a>
            <a style={header} href="/cart" className="navbar-brand"><span style={{marginTop: '2px'}} className="glyphicon glyphicon-shopping-cart">{this.state.cart > 0 ? this.state.cart : null}</span></a>
          </div>
          <div style={noBorder} className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul style={ulStyle} className="nav navbar-nav">
              <li style={ilStyle}></li>
              <li style={ilStyle}><a style={bigFont} href="/about"><span className="">About</span></a></li>
              <li style={ilStyle}><a style={bigFont} href="/availability"><span className="">Availability</span></a></li>
              { this.props.signedIn? <li style={ilStyle}><a style={bigFont} href="/orders">My Orders</a></li> : null }
              <li style={ilStyle}>{ this.props.signedIn? <a style={bigFont} href="/logout">Logout</a> : <a style={bigFont} href="/login">Login</a>} </li> 
            </ul>
          </div>
        </div>
      </nav>
    )
  }
}
