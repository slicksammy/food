class InformationController < SessionsController

  def about
    @signed_in = logged_in?
    render :layout => 'checkout.html.erb'
  end
end
