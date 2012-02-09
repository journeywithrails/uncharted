class Product < ActiveRecord::Base

validates_presence_of     :name, :title, :description,:image
validates_numericality_of :price

file_column :image, :magick => {
   :geometry => "555x525>",
   :versions => {:thumbnail => "150x300", :main => "250x400>"}  
  }
end
