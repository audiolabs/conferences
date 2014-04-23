class Event < ActiveRecord::Base
  attr_accessible :city, :longitude ,:latitude, :comments, :eventend, :country, 
  :eventstart, :fullpaperdeadline, :name, :nameLong, :precisdeadline, :callforpapersurl, 
  :conferenceurl, :tags_attributes, :precisdeadline_tba, :fullpaperdeadline_tba, :peerreviewed, :tag_list, :hindex

  
  has_many :attendances, :dependent => :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, :conferenceurl, :city, :presence => true

  after_validation :geocode, :scope => [:city_changed?, :country_changed?]
  geocoded_by :address
  
  attr_accessor :country_code
  
  # TODO 
  # validate for end date after start date
  
  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
  
  
  def self.tagged_with(name)
      Tag.find_by_name!(name).events
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
  def self.nextByDeadline
    Event.where("(precisdeadline_tba = ? AND fullpaperdeadline > ? ) OR (fullpaperdeadline_tba = ? AND precisdeadline > ?) OR (precisdeadline_tba = ? AND fullpaperdeadline_tba = ? and precisdeadline > ? AND fullpaperdeadline > ?) ", true, Date.today, true, Date.today, false, false, Date.today, Date.today).sort_by(&:closestDeadline).first
  end
  
  
  def earlierDate
    if precisdeadline < fullpaperdeadline
      return precisdeadline
    else 
      return fullpaperdeadline 
    end
  end
  
  def closestDeadline
    if (nofullpaper? && noprecis?)
      return eventstart
    elsif (nofullpaper? && precisdeadline > Date.today)
      return precisdeadline
    elsif (noprecis? && fullpaperdeadline > Date.today)
      return fullpaperdeadline
    elsif ((precisdeadline < fullpaperdeadline) && precisdeadline > Date.today )
      return precisdeadline
    else 
      return fullpaperdeadline 
    end
  end
  
  def address
    [city, country].compact.join(', ')
  end
  
  def singleday?
    (eventstart.to_date == eventend.to_date)
  end
  
  def noprecis?
    (precisdeadline_tba == true)
  end
  
  def nofullpaper?
    (fullpaperdeadline_tba == true)
  end
end
