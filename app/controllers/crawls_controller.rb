class CrawlsController < ApplicationController
  before_action :set_crawl, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :landing_page, :age_verified] #maybe an except here for landing page.


  load_and_authorize_resource except: [:index, :landing_page, :age_verified, :show, :create, :map_location, :update] #need non-admins to both create and show crawls

  # GET /crawls
  # GET /crawls.json
  def index
    @crawls = Crawl.all
    @ability = Ability.new(current_user)
    # Check the search fields for text, then generate results list
    # if params[:text_search].present? && params[:number_search].present?

    if params[:number_search].present? && params[:text_search].present?
      @results = Array.new
      flash[:notice] = "Search using only one field."
    elsif params[:number_search].present?
      @results = Crawl.where("user_id = ?", params[:number_search])
    elsif params[:text_search].present?
      @results = Crawl.search(params[:text_search])
    end
  end

  # GET /crawls/1
  # GET /crawls/1.json
  def show
  end

  # GET /crawls/new
  def new
    @crawl = Crawl.new
  end

  # GET /crawls/1/edit
  def edit
  end

  # POST /crawls
  # POST /crawls.json
  def create
    @crawl = Crawl.new
    if @crawl.name.blank?
      @crawl.name = "Default"
    else
      @crawl.name = params[:name]
    end
    @crawl.address = params[:address]
    @crawl.user_id = current_user.id if user_signed_in?

    respond_to do |format|
      if @crawl.invalid_address
        format.html { redirect_back(fallback_location: root_path, notice: 'Please enter a valid address!') }
        format.json { render json: @crawl.errors, status: :unprocessable_entity }
      elsif @crawl.save
        format.html { redirect_to @crawl, notice: 'Crawl was successfully created.' }
        format.json { render :show, status: :created, location: @crawl }
      else
        format.html { render :new }
        format.json { render json: @crawl.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /crawls/1
  # PATCH/PUT /crawls/1.json
  def update
    respond_to do |format|
      if @crawl.update(crawl_params)
        format.html { redirect_to @crawl, notice: 'Crawl was successfully updated.' }
        format.json { render :show, status: :ok, location: @crawl }
      else
        format.html { render :edit }
        format.json { render json: @crawl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crawls/1
  # DELETE /crawls/1.json
  def destroy

    @crawl.destroy

    respond_to do |format|
      format.html { redirect_to crawls_url, notice: 'Crawl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def age_verified
    cookies[:accepted] = true
    redirect_to root_path
  end

  def map_location
    @crawl = Crawl.find(params[:crawl_id])
    @hash = Gmaps4rails.build_markers(@crawl) do |crawl, marker|
      marker.lat(crawl.latitude)
      marker.lng(crawl.longitude)
      marker.infowindow("<em>" + crawl.address + "</em><br>Remove this marker one day plz!!")
    end
    render json: @hash.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawl
      @crawl = Crawl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crawl_params
      params.require(:crawl).permit(:name, :address, :start_time, :end_time, :date, :brewery_stops, brewery_stops_attributes: [:start_time, :end_time, :id, :brewery_id, :crawl_id]) #this won't work if show and create are not in load_and_authorize_resource
    end
end
