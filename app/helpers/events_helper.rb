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

  def fullpaperdeadline(event)
    html = ""
    if event.nofullpaper?
      html << ""
    elsif event.fullpaperdeadline < Date.today
      html << "<time datetime='#{event.fullpaperdeadline.to_time.iso8601}'>"
      html << "#{event.fullpaperdeadline.strftime("%e. %b %Y")}"
      html << "</time>"
    else
      html << "<time datetime='#{event.fullpaperdeadline.to_time.iso8601}'>"
      html << "#{event.fullpaperdeadline.strftime("%e. %b %Y")}"
      html << "</time>"
      html << " (#{distance_of_time_in_words_to_now(event.fullpaperdeadline)} left)"
    end
    html.html_safe
  end

  def precisdeadline(event)
    html = ""
    if event.noprecis?
      html << ""
    elsif event.precisdeadline < Date.today
      html << "<time datetime='#{event.precisdeadline.to_time.iso8601}'>"
      html << "#{event.precisdeadline.strftime("%e. %b %Y")}"
      html << "</time>"
    else
      html << "<time datetime='#{event.precisdeadline.to_time.iso8601}'>"
      html << "#{event.precisdeadline.strftime("%e. %b %Y")}"
      html << "</time>"
      html << " (#{distance_of_time_in_words_to_now(event.precisdeadline)} left)"
    end
    html.html_safe
  end

  def ispeerreviewed(event)
    html = ""
    if event.peerreviewed?
      html << "(P)"
    else
      html << ""
    end
  end
   
  def deadline_icon(deadline)
    html = ""
    if deadline.to_date < Date.today
      html << ' <i class="fa fa-lock"><span class="sr-only">closed</span></i> '
    elsif deadline.to_date > Date.today - 14
      html << ' <i class="fa fa-exclamation-triangle" ' + deadline_color(deadline) + '><span class="sr-only">imminent</span></i> '
    end
    html.html_safe
  end

  def deadline_class(deadline)
    html = ""
    if deadline.to_date < Date.today
      html << 'class="closed"'
    elsif deadline.to_date > Date.today - 14
      html << 'class="imminent"'
    end
    html.html_safe
  end

  def deadline_color(deadline)
    html = ""
    html << 'style=color:rgb(' + ((deadline.to_date - Date.today).to_i*-(255/90)+255).to_s + ',0,0)'
  end

end
