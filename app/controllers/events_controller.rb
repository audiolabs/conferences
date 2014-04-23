class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @nextByDeadline = Event.nextByDeadline
    
    if params[:tag]
      
       @events = Event.tagged_with(params[:tag]).where("eventend > ?", Time.now).sort_by(&:closestDeadline)
       @past = Event.tagged_with(params[:tag]).where("eventend <= ?", Time.now).paginate(:page => params[:past_page], :per_page => 20).order(:eventend).reverse_order
    else
        @events = Event.where("eventend > ?", Time.now).sort_by(&:closestDeadline)
        @past = Event.where("eventend <= ?", Time.now).paginate(:page => params[:past_page], :per_page => 20).order(:eventend).reverse_order
        
    end
    @currentlocation = Geocoder.search(request.ip)
    respond_to do |format|
      format.html # index.html.erb
      format.ics { render :text => params[:deadlines] ? self.generate_ical_overview_including_deadlines : self.generate_ical_overview }
      format.json { render json: @allevents.to_json(:only => [:id, :name, :startdate, :latitude, :longitude])  }
    end
  end

  def generate_ical_overview
    cal = Icalendar::Calendar.new 
    cal.custom_property("METHOD","PUBLISH")
    @events.each do |e|
      # conference event
      event = Icalendar::Event.new
      event.dtstart = e.eventstart.strftime("%Y%m%d")
      event.dtstart.ical_params = { "VALUE" => "DATE" }      
      event.dtend   = (e.eventend+1).strftime("%Y%m%d")
      event.dtend.ical_params = { "VALUE" => "DATE" , "TZID" => "Europe/London" }
      
      event.summary = e.name
      event.description = ""
      event.location = "#{e.city}, #{e.country}"
      event.url = e.conferenceurl
      event.add_comment(e.comments)
      cal.add event
    end
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    cal.publish
    cal.to_ical
  end

  def generate_ical_overview_including_deadlines
    cal = Icalendar::Calendar.new 
    cal.custom_property("METHOD","PUBLISH")
    @events.each do |e|
      # conference event
      event = Icalendar::Event.new
      event.dtstart = e.eventstart.strftime("%Y%m%d")
      event.dtstart.ical_params = { "VALUE" => "DATE" }      
      event.dtend   = (e.eventend+1).strftime("%Y%m%d")
      event.dtend.ical_params = { "VALUE" => "DATE" , "TZID" => "Europe/London" }
      event.summary = e.name
      event.description = ""
      event.location = "#{e.city}, #{e.country}"
      event.url = e.conferenceurl
      event.add_comment(e.comments)
      cal.add event
      # precis deadline
      unless e.noprecis?
        precis = Icalendar::Event.new
        precis.start = e.precisdeadline.strftime("%Y%m%d")
        precis.summary = "[Deadline] #{e.name} (Abstract/Precis)"
        precis.description = ""
        precis.location = "#{e.city}, #{e.country}"
        precis.url = e.callforpapersurl
        cal.add precis
      end
      # fullpaper deadline
      unless e.nofullpaper?
        paper = Icalendar::Event.new
        paper.start = e.fullpaperdeadline.strftime("%Y%m%d")
        paper.summary = "[Deadline] #{e.name} (Paper)"
        paper.description = ""
        paper.location = "#{e.city}, #{e.country}"
        paper.url = e.callforpapersurl
        cal.add paper
      end
    end
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    cal.publish
    cal.to_ical
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.ics { render :text => self.generate_ical_event }
      format.json { render json: @event }
    end
  end
  
  def generate_ical_event
    cal = Icalendar::Calendar.new 
    cal.custom_property("METHOD","PUBLISH")
    event = Icalendar::Event.new
    event.dtstart = @event.eventstart.strftime("%Y%m%d")
    event.dtstart.ical_params = { "VALUE" => "DATE" }      
    event.dtend   = (@event.eventend+1).strftime("%Y%m%d")
    event.dtend.ical_params = { "VALUE" => "DATE" , "TZID" => "Europe/London" }
    event.summary = @event.name
    event.description = ""
    event.location = "#{@event.city}, #{@event.country}"
    event.url = @event.conferenceurl
    event.add_comment(@event.comments)

    event.alarm.description =  "Alarm notification"
    event.alarm.trigger =  "-P1" # 1 day before

    cal.add event
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    cal.publish
    cal.to_ical
  end
  

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        EventMailer.new_event(@event).deliver
        
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
