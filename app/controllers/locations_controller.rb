class LocationsController < ApplicationController
  # User must be signed in to create a new location
  before_filter :authenticate_user!,
    :only => [:new, :edit]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    # Clear session[:locations] for a new search
    session[:locations] = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    # Store location ID in session in case we want to access it in Contract controller
    session['location'] = @location.id

    #Find when the location is booked and pass that to javascript function for rendering the calendar
    @booked = {}
    @location.contracts.each do |contract|
      dates = {contract.id => {'begin' => contract.begin.strftime('%B %d, %Y'), 'end' => contract.end.strftime('%B %d, %Y')}}
      @booked.merge!(dates)
    end
    @booked = @booked.to_json

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # /search
  def search
    if !session[:locations].blank?
      @locations = []
      session[:locations].each do |location|
        @locations << Location.find(location)
      end
      @notice = session[:notice]
    elsif !params[:address].blank?
      address = params[:address]
      @latlng = Geocoder.coordinates(address)
      @notice = "<p>Showing the closest spaces to <u>#{address}</u> <a href='/' class='blue'>(try another search)</a>:</p>"
      @locations = Location.near(@latlng, 10)
    else
      @notice = "<p>Your location wasn't found, but here are some locations for you to consider:</p>"
      @locations = Location.cheapest.top_ten
    end

    # Store the resulting location IDs in a session array
    @locations.each do |location|
      (session[:locations] ||= []) << location.id
      session[:notice] = @notice
    end

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])

    if current_user.id != @location.user_id
      flash[:alert] = "You don't have permission to edit this storage space listing."
      redirect_to :action => "show", :id => @location.id    
    end
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
