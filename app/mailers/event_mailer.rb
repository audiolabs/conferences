class EventMailer < ActionMailer::Base
  default from: "root@localhost"
  
  def new_event(event)
      @event = event
      @url  = url_for(event)
      mail(:to => "root@localhost", :subject => "New Conference announced")
    end
end
