class Banner < ActiveRecord::Base
  
  
 validates_presence_of      :title,:image 
 file_column :image, :magick => {
   #:geometry => "555x525>",
   :versions => {:main => "728x90!"}  
  } 
   file_column :sub_image, :magick => {
   #:geometry => "555x525>",
   :versions => {:main => "120x90!"}  
  } 
  
end
