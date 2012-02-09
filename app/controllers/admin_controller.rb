class AdminController < ApplicationController

  before_filter :authorizeadmin, :except => [:login, :index]
  layout "admin"
  
def index  
    if session[:user].blank? 
     redirect_to :action => 'login'
	else
	 admin = AdminUser.find_by_user_id(session[:user].id) 
	 if admin 
	    redirect_to :action => 'home', :id => session[:user].id 
	 else
	  redirect_to :action => 'login'
	 end
	end     
 end
 
def login
  session[:user] = nil
  if request.post?
   if session[:user] = User.authenticate(params[:email],params[:password])
       adminuser = AdminUser.find_by_user_id(session[:user].id)
	    if !adminuser.blank?
         flash[:notice] = "You have Logged in as Admin"
         redirect_to :action => 'home', :id => session[:user].id and return
        else
		session[:user] = nil
        flash[:notice] = "Invalid Username and Password"
        end
		else
		flash[:notice] = "Invalid Username and Password"
	   end
  end  
  render :layout => false
end

 def change_password
    return unless request.post?
    if current_user = AdminUser.authenticate(session[:user].email, params[:old_password])
      if (params[:password] == params[:password_confirmation])
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        flash[:notice] = current_user.save ?
              "Password changed" :
              "Password not changed" 
	redirect_to :action => 'list'
      else
        flash[:notice] = "Password mismatch" 
        @old_password = params[:old_password]
      end
    else
      flash[:notice] = "Wrong password" 
    end
  end









  
def home
 @user = User.find(params[:id])
end
 
def profile
 @profile = User.find(params[:id])
end 
 
def profile_edit
 @user = User.find(params[:id])
end 
  
 def list
   @list = AdminUser.find(:all, :conditions => ["status = 0 "])
 end
 
 def new
 @user = User.new
 render :layout => 'admin'
 end
 
 def create
  @user = User.new(params[:user])  
  @user.created_at = Time.now
  if  @user.save
      @settings = UserSetting.new(:user_id=>@user.id)
      @settings.save
      @admin = AdminUser.new
	  @admin.user_id = @user.id
	  @admin.save
      flash[:notice] = "New Admin was Successfully Created"
	   redirect_to :controller => 'admin', :action => 'list' and return
	else
	render :action => 'new' and return
	end
 end
 
 


def profile_update
@user = User.find(params[:id])
@user.updated_at = Time.now
if @user.update_attributes(params[:user])
flash[:notice]= "AdminUser Details was Successfully Updated"
redirect_to :action => 'list'
else
render :action => 'profile_edit'
end
end


 
def delete
@user = User.find(params[:id])
@user.status = 1
if @user.update_attributes(params[:user])
@admin = AdminUser.find_by_user_id(params[:id])
@admin.status = 1
@admin.update_attributes(params[:admin])
flash[:notice]= "AdminUser was Successfully Deleted."
redirect_to :action => 'list'
else
flash[:notice]= "Unable to Delete AdminUser."
redirect_to :action => 'list'
end

end 
  
 
 def search
 @type = params[:type]
 profile = Profile.find(:all, :conditions=>["name LIKE ? OR primary_residence LIKE ? OR places_lived LIKE ? OR places_traveled LIKE ? OR personal_interests LIKE ? OR work_life LIKE ? OR future_plans LIKE ? OR date_joined LIKE ? OR birthday LIKE ?","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%"])
  if profile.size!=0
  @list = Array[]
  profile.each do |p| 
  user = User.find_by_id(p.user_id) 
  @list.push(user.id)
  end
  @users =User.find(:all, :conditions => [" id in ( '#{@list.join(",")}')  AND user_type LIKE ?", params[:type]])
  
  else
  @users = User.find(:all, :conditions=>["username LIKE ? OR email LIKE ? AND(user_type LIKE ?)", "%#{params[:search]}%", params[:search],params[:type]])
  end
  respond_to do |f|
  f.html {render :template=>"admin/list", :locals=>{:users=>@users, :type => params[:type]}}
  end
 end
  
 def logout
  session[:user]=nil
  flash[:notice]="You have logged out."
  redirect_to :action => 'login'
 end
 
  
end
