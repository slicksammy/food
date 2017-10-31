class Packages extends React.Component {
  constructor() {
    super();
    this.addPackage = this.addPackage.bind(this);
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

  render() {
    var centered = {
      textAlign: 'center'
    }

    var packageName = {
      textAlign: 'center',
      fontSize: '50px'
    }

    var packageDescription = {
      textAlign: 'center',
      fontSize: '35px',
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

    var packages = this.props.packages.map( pkg => {
      return(
        <div style={centered}>
          <h2 style={packageName}>{pkg.name}</h2>
          <h2 style={packageDescription}>{pkg.description}</h2>
          <h3 style={packagePrice}>${pkg.price}</h3>
          <button style={buttonStyle} className="btn blue" onClick={()=> this.addPackage(pkg.uuid)}>Add Products</button>
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
