class ForumPost < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum_threads
	belongs_to :forum_category	
	 validates_presence_of     :subject, :content
	 
end
