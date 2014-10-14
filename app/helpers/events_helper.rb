module EventsHelper
  def join_tags(event)
    event.tags.map { |t| t.name }.join(", ")
  end

  def duration(event)
    html = ""
    if event.singleday?
      html << "<time datetime='#{event.eventstart.to_time.iso8601}'>"
      html << "#{event.eventstart.strftime("%e. %b %Y")}"
      html << "</time>"
    else
      html << "<time datetime='#{event.eventstart.to_time.iso8601}'>"
      html << "#{event.eventstart.strftime("%e. %b %Y")} - #{event.eventend.strftime("%e. %b %Y")}"
      html << "</time>"
    end
    html.html_safe
  end

  def deadline(deadline)
    html = ""
    if deadline < Date.today
      html << "<time class='datetime' datetime='#{deadline.to_time.iso8601}'>"
      html << "#{deadline.strftime("%e. %b %Y")}"
      html << "</time>"
    else
      html << "<time class='datetime' datetime='#{deadline.to_time.iso8601}'>"
      html << "#{deadline.strftime("%e. %b %Y")}"
      html << "</time>"
      html << " (#{distance_of_time_in_words_to_now(deadline)} left)"
    end
    html.html_safe
  end

  def ispeerreviewed(event)
    html = ""
    if event.peerreviewed?
      html << ' <i class="fa fa-eye"><span class="sr-only">peer reviewed</span></i> '
    else
      html << ''
    end
    html.html_safe
  end
   
  def deadline_icon(deadline)
    html = ""
    if deadline.to_date < Date.today
      html << ' <i class="fa fa-lock"><span class="sr-only">closed</span></i> '
    elsif deadline.to_date < Date.today + 64
      html << ' <i class="fa fa-exclamation-triangle" ' + deadline_color(deadline) + '><span class="sr-only">imminent</span></i> '
    end
    html.html_safe
  end

  def deadline_class(deadline)
    html = ""
    if deadline.to_date < Date.today
      html << 'class="closed"'
    elsif deadline.to_date < Date.today + 14
      html << 'class="imminent"'
    end
    html.html_safe
  end

  def deadline_color(deadline)
    html = ""
    html << 'style=color:rgb(' + ((deadline.to_date - Date.today).to_i*-(255/90)+255).to_s + ',0,0)'
  end

end
