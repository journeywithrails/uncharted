# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_sea_session_id'
   #include Authentication
   include Sitealizer  
   before_filter :use_sitealizer
   before_filter :copy_banner

  
  
  
#method for to display the banner
def copy_banner
  @banner = Banner.find(1)
end  
  
#-----------forum methods-----------
  def forum_categories_list
  	@forum_categories = ForumCategory.find :all, :select=>:title
  end
  
   def remove_underscore(str)
  	ret = str.gsub!('_', ' ')
  	@str = (!ret)? str : ret
  end 
  
    #def is_admin?
  #	@admin_check ||= User.find :first, :conditions=>{:id =>session[:user].id}
 # 	if @admin_check
  #		@admin = true
 # 	else
  	#	@admin = false
  #	end
  #end
  

#-----------------------------------
  
#----------mail metod---------------
  #def user_update
    #@user = User.find(session[:user].id)
    #if @user
     # @user.update_attribute("updated_at", Time.now)
    #end
  #end

  def session_mail
  if !session[:user].blank?
     mail = UserMail.find(:all, :conditions=>["to_user LIKE ? AND user_read LIKE ?",session[:user].id,0])
    #mail = UserMail.find(:all, :conditions=>{:to_user=>session[:user].id, :user_read=>"0"})
    session[:mail]= mail.length
	end
  end
#------ --------------------------- -

#network list

def network_list
if !session[:user].blank?
@network = User.find_by_id(session[:user].id)
@article = Article.find(7)
end
end


 
 def authorizeadmin
  unless AdminUser.find_by_user_id(session[:user]) 
 flash[:notice] = "Please log in"
  redirect_to :controller => 'admin', :action => 'login'
  end
 end 
 
 def login_required
  unless User.find_by_id(session[:user])
  flash[:notice] = "Please log in"
  redirect_to :controller => 'home', :action => 'login'
  end
 end
  
end
