require 'distance'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def index
  end

  def places
    @places = Place.apartment
  end

  def place
    @place = Place.find params["id"]
    @status = @place.status
    @data = Distance.sort_stores(@place).first(5)
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
      p = Place.create!(name: params["name"], phone_number: params["phone"], address: params["address"], internal_type: params["internal_type"])
      if params["note"]
        p.notes.create!(note_text: params["note"])
      end
    end
  end
end
