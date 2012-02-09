class FeedBack < ActiveRecord::Base
belongs_to :user, :class_name => "User", :foreign_key => "user_id"
validates_presence_of     :Subject, :Description
file_column :file

end
