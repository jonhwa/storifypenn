class SearchesController < ApplicationController
	def show
		@search = Search.find(params[:id])

		@search.locations.each do |location|
			(session[:locations] ||= []) << location
	      	session[:notice] = @notice
	    end

	    @locations = []
	    @search.locations.each do |location|
	    	@locations << Location.find(location)
	    end

	    @notice = "<p>Showing the closest spaces to <u>#{@search.address}</u> <a href='/' class='blue'>(try another search)</a>:</p>"

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
		@search.get_locations(@search.address, params[:search_dates])

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
