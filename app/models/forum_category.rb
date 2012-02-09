class ForumCategory < ActiveRecord::Base
	has_many :forum_threads
	has_many :forum_posts, :through=> :forum_threads
	has_many :users, :through=> :forum_threads
	
	validates_presence_of      :title, :description
	validates_uniqueness_of   :title, :case_sensitive => false
	validates_length_of       :title,    :within => 3..20
	
	
end
