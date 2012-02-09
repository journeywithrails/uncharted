class UserSetting < ActiveRecord::Base

has_one :user
belongs_to :user, :class_name => "User", :foreign_key => "user_id"

end
