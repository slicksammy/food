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
      // paddingBottom: '-3px'
    }

    var header = {
      // fontSize: '27px',
      // // color: '#FCFCFC',
      // // width: '30%',
      // marginRight: '40px',
      // marginTop: '-8px'
      paddingRight: '10px',
      paddingLeft: '10px'
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
      paddingTop: '4px',
      fontSize: '14px',
      marginRight: '25px'
    }

    var red = {
      // color: 'red'
    }

    var img = {
      width: '75px'
    }

    var steaksStyle = {
      // border: '2px solid green',
      // borderRadius: '5px',
      padding: '3px 3px 3px 3px',
      // boxShadow: '5px',
      color: 'white',
    }

    var cartColor = this.state.cart > 0 ? 'blue' : ''

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
            <a href="/" className="navbar-brand navbar-header"><img style={img} src="assets/logo_simple.png" /></a>
            <a href="/steaks" className="navbar-brand navbar-header"><span className="layer-shadow1 shop-background" style={steaksStyle}>Steaks</span></a>
            <a href="/cart" className="navbar-brand navbar-header"><span style={{marginTop: '2px', color: cartColor}} className="glyphicon glyphicon-shopping-cart">{this.state.cart > 0 ? this.state.cart : null}</span></a>
          </div>
          <div style={noBorder} className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul style={ulStyle} className="nav navbar-nav navbar-right">
              {/*<li style={ilStyle}></li>*/}
              <li style={ilStyle}><a style={bigFont} href="/about"><span className="">FAQ</span></a></li>
              <li style={ilStyle}><a style={bigFont} href="/cooking"><span className="">Cooking</span></a></li>
              {/*<li style={ilStyle}><a style={bigFont} href="/holidays"><span className="">Holidays</span></a></li>*/}
              <li style={ilStyle}><a style={bigFont} href="/availability"><span className="">Availability</span></a></li>
              { this.props.signedIn? <li style={ilStyle}><a style={bigFont} href="/orders">My Orders</a></li> : null }
              <li style={ilStyle}><a style={bigFont} href="/about#contact"><span className="">Contact</span></a></li>
              <li style={ilStyle}>{ this.props.signedIn? <a style={bigFont} href="/logout">Logout</a> : <a style={bigFont} href="/login">Login</a>} </li> 
            </ul>
          </div>
        </div>
      </nav>
    )
  }
}
