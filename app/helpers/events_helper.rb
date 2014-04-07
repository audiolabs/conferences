module EventsHelper
  def join_tags(event)
    event.tags.map { |t| t.name }.join(", ")
  end
  
  def duration(event)
    html = ""
    if event.singleday?
      html << "#{event.eventstart.strftime("%e. %b %Y")}"
    else
      html << "#{event.eventstart.strftime("%e. %b %Y")} - #{event.eventend.strftime("%e. %b %Y")}"
    end
  end
  
  def fullpaperdeadline(event)
    html = ""
    if event.nofullpaper?
      html << ""
    elsif event.fullpaperdeadline < Date.today
      html << "#{event.fullpaperdeadline.strftime("%e. %b %Y")}"
    else
      html << "#{event.fullpaperdeadline.strftime("%e. %b %Y")} (#{distance_of_time_in_words_to_now(event.fullpaperdeadline)}) left"
    end
  end
  
  def precisdeadline(event)
     html = ""
      if event.noprecis?
        html << ""
      elsif event.precisdeadline < Date.today
        html << "#{event.precisdeadline.strftime("%e. %b %Y")}"
      else
        html << "#{event.precisdeadline.strftime("%e. %b %Y")} (#{distance_of_time_in_words_to_now(event.precisdeadline)}) left"
      end
  end
  
  def ispeerreviewed(event)
     html = ""
     if event.peerreviewed?
       html << "(P)"
     else
       html << ""
     end
   end
end