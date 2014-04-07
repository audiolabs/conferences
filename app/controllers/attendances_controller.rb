class AttendancesController < ApplicationController
  # GET /attendances
  # GET /attendances.json
  def index
    @event = Event.find(params[:event_id])
    
    @attendance = @event.attendances.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendances }
    end
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/new
  # GET /attendances/new.json
  def new
    @attendance = Attendance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find(params[:id])
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.create(params[:attendance])
    
    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @event, notice: 'Attendance was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attendances/1
  # PUT /attendances/1.json
  def update
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find(params[:id])

    respond_to do |format|
      if @attendance.update_attributes(params[:attendance])
        format.html { redirect_to event_path(@event), notice: 'Attendance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @event = Event.find(params[:event_id])
    
    @attendance = @event.attendances.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
