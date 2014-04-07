class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :event
  # attr_accessible :title, :body
end
