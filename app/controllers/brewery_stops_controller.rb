class BreweryStopsController < ApplicationController
  before_action :set_brewery_stop, only: [:show, :edit, :update, :destroy]

  # GET /brewery_stops
  # GET /brewery_stops.json
  def index
    @brewery_stops = BreweryStop.all
  end

  # GET /brewery_stops/1
  # GET /brewery_stops/1.json
  def show
  end

  # GET /brewery_stops/new
  def new
    @brewery_stop = BreweryStop.new
  end

  # GET /brewery_stops/1/edit
  def edit
  end

  # POST /brewery_stops
  # POST /brewery_stops.json
  def create
    @brewery_stop = BreweryStop.new(brewery_stop_params)

    respond_to do |format|
      if @brewery_stop.save
        format.html { redirect_to @brewery_stop, notice: 'Brewery stop was successfully created.' }
        format.json { render :show, status: :created, location: @brewery_stop }
      else
        format.html { render :new }
        format.json { render json: @brewery_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brewery_stops/1
  # PATCH/PUT /brewery_stops/1.json
  def update
    respond_to do |format|
      if @brewery_stop.update(brewery_stop_params)
        format.html { redirect_to @brewery_stop, notice: 'Brewery stop was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery_stop }
      else
        format.html { render :edit }
        format.json { render json: @brewery_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brewery_stops/1
  # DELETE /brewery_stops/1.json
  def destroy
    @brewery_stop.destroy
    respond_to do |format|
      format.html { redirect_to brewery_stops_url, notice: 'Brewery stop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery_stop
      @brewery_stop = BreweryStop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_stop_params
      params.require(:brewery_stop).permit(:start_time, :end_time, :brewery_id, :crawl_id)
    end
end
