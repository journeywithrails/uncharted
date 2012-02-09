class Profile < ActiveRecord::Base

belongs_to :user
belongs_to :user, :class_name => "User", :foreign_key => "user_id"

file_column :profile_image, :magick => {
   :geometry => "555x525>",
   :versions => {:thumbnail => "80x300", :main => "250x400>"}  
  }


end
