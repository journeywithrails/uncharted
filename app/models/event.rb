class Event < ActiveRecord::Base

belongs_to :user, :class_name => "User", :foreign_key => "user_id"
validates_presence_of  :event_date, :event_location, :event_description, :event_title

end
