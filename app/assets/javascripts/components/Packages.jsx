class Packages extends React.Component {
  constructor() {
    super();
    this.addPackage = this.addPackage.bind(this);
    this.color = this.color.bind(this)
  }

  addPackage(package_uuid) {
    $.ajax({
      method: 'POST',
      url: '/cart/package',
      data: { uuid: package_uuid },
      success: function(response) {
        window.location = '/cart'
      }
    })
  }

  color(index) {
    switch(index % 2) {
      case 0:
        return('#e6e4e4')
      case 1:
        return('#ffffff')
    }
  }

  render() {

    var packageName = {
      textAlign: 'center',
      fontSize: '50px',
      paddingTop: '10px'
    }

    var packageDescription = {
      textAlign: 'center',
      fontSize: '25px',
      fontFamily: "'Crimson Text', serif",
      textTransform: 'uppercase',
      paddingLeft: '10px',
      paddingRight: '10px'
    }

    var packagePrice = {
      textAlign: 'center',
      fontSize: '35px'
    }

    var packageStyle = {
      paddingTop: '20px',
      paddingBottom: '20px'
    }

    var buttonStyle = {
      textAlign: 'center',
      fontSize: '25px',
      color: 'white'
    }

    var packages = this.props.packages.map( (pkg,index) => {
      var centered = {
        textAlign: 'center',
        background: this.color(index),
      }

      var restPrice = {
        textDecoration: 'line-through',
        color: '#d40766'
      }

      return(
        <div style={centered}>
          <h2 style={packageName}>{pkg.name}</h2>
          <h2 style={packageDescription}>{pkg.description}</h2>
          <h3 style={restPrice}>regular price: ${pkg.regular_price}</h3>
          <h3 style={packagePrice}>${pkg.price} ({pkg.discount}% OFF)</h3>
          <button style={buttonStyle} className="btn shop-background" onClick={()=> this.addPackage(pkg.uuid)}>Add Steaks</button>
          <Products products={pkg.products} showButtons={false} showPackageTotals={true} showCartTotals={false} />
        </div>
      )
    })

    return(
      <div>
        {packages}
      </div>
    )
  }
}
