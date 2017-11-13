require 'checkout/order_totals'
require 'stats'

class AdminController < SessionsController
  include CheckoutHelper
  include AdminHelper

  before_action :authorize!

  before_action :stats, only: [:dashboard, :get_stats]

  def authorize!
    unless admin?
      @message = 'Woops! This page does not exist.'

      render :file => 'public/nothing_here.html.erb', :layout => 'sessions', status: 500
    end
  end

  def index
    orders = Order.ordered
    @orders = format_orders(orders)
  end

  def dashboard
    
  end

  def analytics
    @page_visits = {}

    PageVisit.ordered.reverse.each do |a|
      @page_visits[a.session_id] = [] unless @page_visits[a.session_id]
      @page_visits[a.session_id] << a.url
    end

    @page_visits
  end

  def deliver_order
    order = Order.find_by_uuid(params["uuid"])

    if order
      order.deliver!
      OrderMailer.delivered(order, note: params["note"]).deliver!

      render body: nil, status: 202
    else
      render body: nil, json: { error: 'something went wrong' }
    end
  end

  def stats
    i = Stats.new(params["time"] || 60)
    @stats = { orders: i.orders, users: i.users, carts: i.carts, page_views: i.unique_page_views_non_admins, unique_visitors: i.unique_visitors_non_admins }
  end

  def get_stats
    render json: { stats: @stats }
  end

  def lables
    orders = Order.paid.for_today

    @orders = orders.map { |order| format_label(order) }.in_groups_of(2).map { |group| group.compact } # take cares when there is an odd number
  end

  def places
    places = Place.ordered
    types = PlaceType.all
    @data = {types: types, places: places}

    # render json: { data: data }
  end

  def place
    @place = Place.find params["id"]
    @status = @place.status
    @data = Place.grocery.first(5)
    # @data = Distance.sort_stores(@place).first(5)
    @notes = @place.notes.ordered
    @statuses = Status.all
  end

  def notes
    place = Place.find params["id"]

    place.notes.create!(note_text: params["text"])

    render nothing: true
  end

  def update_status
    Place.find(params["id"]).status = params["status"]
  end

  def get_callbacks
    c = Place.find(params["id"]).callbacks

    render nothing: true, json: { callbacks: c }
  end

  def new_place
    if request.post?
      p = Place.create!(name: params["name"], phone_number: params["phone"], address: params["address"], place_type_id: params["place_type"])
      if params["note"].present?
        p.notes.create!(note_text: params["note"])
      end

      redirect_to '/places'
    else 
      @types = PlaceType.all
    end
  end

  def search
    notes = Note.search(params["search"]).sort_by(&:place_id).map{ |n| { text: n.note_text, place_id: n.place_id, name: n.place.name } }

    render nothing: true, json: { notes: notes }
  end

  private

  def products(order)
    begin
      to_string(order.products.any? ? order.products : ::Checkout::OrderTotals.new(order: order).items)
    rescue ::Checkout::OrderTotals::MissingCartError, ::Checkout::OrderTotals::NoItemsInCart => e
      []
    end
  end

  def format_orders(orders)
    orders.map{ |o| {order: format_order(o), items: products(o), status: o.status, name: o.user.try(:full_name), uuid: o.uuid } } # try in case something weird happens and order is created without user
  end

end
