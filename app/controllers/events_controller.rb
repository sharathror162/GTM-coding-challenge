class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  ## custom methods
  def find_by_org
    #binding.pry


  end

  def find_by_host

  end

  def find_by_host_org
  end

  def display_result
    org_given = params[:user_org]
    num_of_events = params[:last_num] || 10
    host_given = params[:host_name]

    if host_given && org_given
      res = Event.all.where("org = ? AND hostname = ?", org_given, host_given)
    elsif org_given
      res = Event.all.where(org: org_given)
    end
    @result = res.last(num_of_events) if num_of_events.length>0
    @result.reverse!
  end

  def display_host
      num_of_events = "10" if params[:last_num].blank?
      host_given = params[:host_name]
      if host_given.blank?
        flash.now[:notice] = 'Host name cannot be empty.'
        render :find_by_host
      elsif (/\A\w+@+\w+\.+com|edu|gov\z/).match(host_given).nil?
        flash.now[:notice] = 'Invalid Host name.'
        render :find_by_host
      else
        res = Event.all.where(hostname: host_given)
        @result = res.last(num_of_events) if num_of_events.length>0
        @result.reverse!
       end
  end

  ##

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:hostname, :org, :created)
    end
end
