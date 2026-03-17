class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    
    # This filter ensures you only see YOUR entries
    if current_user
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => current_user["id"] })
    else
      @entries = []
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["place"]["name"]
    @place.save
    redirect_to "/places"
  end

end