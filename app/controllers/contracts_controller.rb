class ContractsController < ApplicationController
  # User must be signed in to create a new contract
  before_filter :authenticate_user!,
    :only => [:new]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
    @location = Location.find(params[:location_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @contract = Contract.find(params[:id])
    @location = Location.find(params[:location_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.json
  def new
    @contract = Contract.new
    @location = Location.find(params[:location_id])

    #Find when the location is booked and pass that to javascript function for rendering the calendar
    @booked = {}
    @location.contracts.each do |contract|
      dates = {contract.id => {'begin' => contract.begin.strftime('%B %d, %Y'), 'end' => contract.end.strftime('%B %d, %Y')}}
      @booked.merge!(dates)
    end
    @booked = @booked.to_json

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
    @location = Location.find(params[:location_id])
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(params[:contract])
    @location = Location.find(params[:location_id])

    respond_to do |format|
      if @contract.save
        format.html { redirect_to location_contract_path(@location.id, @contract.id), notice: 'Contract was successfully created.' }
        format.json { render json: @contract, status: :created, location: location_contract_path(@location.id, @contract.id) }

        Notifications.new_contract(@contract).deliver
      else
        format.html { render action: "new" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.json
  def update
    @contract = Contract.find(params[:id])
    @location = Location.find(params[:location_id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end
end
