class ApplicationController < SessionsController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :permit_page_visit_params, only: [:record_page_visit]

  def index
    
  end

  # TODO remove session info from here
  def version
    render status: 200, json: { version: 1.2, user: session[:user_uuid] }
  end

  def routing_error
    @message = 'Woops! This page does not exist.'

    render :file => 'public/nothing_here.html.erb'
  end

  def record_page_visit
    unless admin?
      PageVisit.create!(url: params["url"], user_uuid: current_user_uuid, ip_address: request.remote_ip)
    end
    
    render body: nil
  end

  def permit_page_visit_params
    params.permit(:url)
  end

  def places
    places = Place.all
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

  def new
    if request.post?
      p = Place.create!(name: params["name"], phone_number: params["phone"], address: params["address"], place_type_id: params["place_type"])
      if params["note"].present?
        p.notes.create!(note_text: params["note"])
      end
    else 
      @types = PlaceType.all
    end
  end

  def search
    notes = Note.search(params["search"]).sort_by(&:place_id).map{ |n| { text: n.note_text, place_id: n.place_id, name: n.place.name } }

    render nothing: true, json: { notes: notes }
  end
end
