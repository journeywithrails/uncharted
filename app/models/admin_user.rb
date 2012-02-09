class AdminUser < ActiveRecord::Base

belongs_to :user, :class_name => "User", :foreign_key => "user_id"


	def after_destroy
		if AdminUser.count.zero?
			raise "cant delete last Admin"
		end
	end	

end