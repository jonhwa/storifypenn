class SearchesController < ApplicationController
	def show
		# Check for a past search
	    if !session[:locations].blank?
	      @locations = []
	      session[:locations].each do |location|
	        @locations << Location.find(location)
	      end
	      @notice = session[:notice]
	    elsif !params[:address].blank?
	      address = params[:address]
	      dates = params[:search_dates]
	      @locations = Location.search(address, dates)
	      @notice = "<p>Showing the closest spaces to <u>#{address}</u> <a href='/' class='blue'>(try another search)</a>:</p>"
	    else
	      @notice = "<p>Your location wasn't found, but here are some locations for you to consider:</p>"
	      @locations = Location.cheapest.top_ten
	    end

	    # Store the resulting location IDs in a session array
	    session.delete(:locations)
	    @locations.each do |location|
	      (session[:locations] ||= []) << location.id
	      session[:notice] = @notice
	    end

	    respond_to do |format|
	      format.html # search.html.erb
	      format.json { render json: @locations }
	    end
	end

	def new
		@search = Search.new

		respond_to do |format|
			format.html
			format.json { render json: @search }
		end
	end

	def create
		@search = Search.new(params[:search])
		@search.date_range(params[:search_dates])

		respond_to do |format|
			if @search.save
				format.html { redirect_to @search }
		        format.json { render json: @search, status: :created, search: @search }
			else
				format.html { render action: "new" }
				format.json { render json: @search.errors, status: :unprocessable_entity }
			end
		end
 	end
end
