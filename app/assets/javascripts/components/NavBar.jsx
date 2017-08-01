class NavBar extends React.Component {
  constructor() {
    super();
    this.state = { cart: 2 };
    this.cartEmpty = this.cartEmpty.bind(this)
  }

  cartEmpty() {
    return(this.state.cart == 0)
  }

  render() {
    var navStyle = {
      borderRadius: '0px'
    }

    var aStyle = {
      ':hover': {
        cursor: 'pointer'
      }
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

    return(
      <nav className="navbar navbar-default" style={navStyle}>
        <div className="container-fluid">
          <div className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-brand">I<span className="glyphicon glyphicon-heart"></span>Meat</a>
            { this.cartEmpty() ? null : <a className="navbar-brand" href="/cart"><span className="glyphicon glyphicon-shopping-cart">{this.state.cart}</span></a> }
          </div>
          <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav">
              <li><a href="/about">About</a></li>
            </ul>
          </div>
        </div>
      </nav>
    )
  }
}
