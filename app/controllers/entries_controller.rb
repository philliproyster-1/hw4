class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = Place.find_by({ "id" => params["place_id"] })
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["entry"]["title"]
    @entry["description"] = params["entry"]["description"]
    @entry["occurred_on"] = params["entry"]["occurred_on"]
    @entry["place_id"] = params["entry"]["place_id"]

    # Rubric: Assign new entries to the logged-in user
    @entry["user_id"] = current_user["id"]

    if params["uploaded_image"].present?
      @entry.uploaded_image.attach(params["uploaded_image"])
    end

    @entry.save
    redirect_to "/places/#{@entry['place_id']}"
  end

  def destroy
    @entry = Entry.find_by({ "id" => params["id"] })
    if @entry && @entry["user_id"] == current_user["id"]
      @entry.destroy
    end
    redirect_to "/places/#{@entry['place_id']}"
  end
end