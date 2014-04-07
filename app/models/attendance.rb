class Attendance < ActiveRecord::Base
  attr_accessible :accepted, :attending, :comments, :name, :planningtosubmit, :submitted
  belongs_to :event
end
