class Article < ActiveRecord::Base

acts_as_ferret
	belongs_to :user
	belongs_to :article_category
	validates_presence_of     :article_title, :article_body, :article_image
	
	 file_column :article_image, :magick => {
   #:geometry => "555x525>",
   :versions => {:main => "190x125!"}  
  }
  
end
