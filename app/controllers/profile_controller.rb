class ProfileController < ApplicationController

before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'


#methos to change password

def change_password
 @user = User.find(params[:id])
 return unless request.post?
    if current_user = User.authenticate(session[:user].email, params[:old_password])
      if (params[:password] == params[:password_confirmation])
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        flash[:notice] = current_user.save ?
         "Your Password has been changed" :
         "Unable to change your Password" 
	       redirect_to :action => 'profile_show', :user=> session[:user].id
       else
        flash[:notice] = "Password mismatch" 
        @old_password = params[:old_password]
      end
   else
    flash[:notice] = "Incorrect old password" 
    end
end

def profile_show
@profile = User.find(params[:user])
@list = Array[]
useradd = UserNetwork.find(:all, :conditions=>["user_id = '#{@profile.id}' AND STATUS = '1'"])
 if !useradd.blank?
 for user in useradd
 @list.push("'"+user.friend_id+"'")
 end
 end
userfrd = UserNetwork.find(:all, :conditions=>["friend_id = '#{@profile.id}' AND STATUS = '1'"])		
 if !userfrd.blank?
 for user in userfrd
 @list.push("'"+user.user_id+"'")
 end
 end 
 if !@list.blank?
 page = params[:page].blank? ? 1 : params[:page]
 @list = User.paginate :per_page=>50, :page => page, :conditions => ["id in (#{@list.join(",")})"], :order => "last_login DESC"
 end
 
# conditions for Netwok updates
if session[:user].id == @profile.id
@updates_list = Array[]
updates_id = UserNetwork.find(:all, :conditions=>["friend_id LIKE ? AND STATUS = '0'", session[:user].id])
if !updates_id.blank?
for updates in updates_id
@updates_list.push("'"+updates.user_id+"'")
end
 page = params[:page].blank? ? 1 : params[:page]
 @updates  = User.paginate :per_page=>50, :page => page, :conditions => ["id in (#{@updates_list.join(",")})"], :order => "last_login DESC"
 else
 @updates = ""
end
end
render :layout => 'home'
end


def edit
@user = User.find(params[:id])
render :layout => 'home'
end

def update
@user = User.find(params[:id])
@user.updated_at = Time.now
if !params[:user][:birthday].blank?
@date = params[:user][:birthday].split('-')
@month = @date[0]
@day = @date[1]
@year = @date[2]
params[:user][:birthday] = "#{@month}/#{@day}/#{@year}"
end
if @user.update_attributes(params[:user])
flash[:notice] = "User Details Successfully Updated."
redirect_to :action => 'profile_show', :user => params[:id]
else
flash[:notice] = "Unable to Update User Details."
render :action => 'edit'
end
end

def settings
  @settings = UserSetting.find(:first,:conditions=>{:user_id=>session[:user].id})
  render :layout => 'home'
end
  
def update_settings
    user_settings = params[:settings]
    user_settings[:user_id] = session[:user].id
    @settings = UserSetting.find(:first, :conditions=>{:user_id=>session[:user].id})
    if @settings.update_attributes(user_settings)
      flash[:notice] = "Your settings have been updated."
    else
      flash[:notice] = "There was an error while updating your settings"
    end
    redirect_to user_settings_url(:user => session[:user].id)
end

def send_request
 @profile = User.find(params[:id])
 @network_params = {:user_id => session[:user].id, :friend_id => @profile.id, :created_at => Time.now }
 @network = UserNetwork.new(@network_params)
 if @network.save
 flash[:notice] = "Your network request for #{@profile.First_Name} has been sent."
 redirect_to :action => 'profile_show', :user => @profile.id and return
 else
 redirect_to :action => 'profile_show', :user => session[:user].id and return
 flash[:notice] = "Unable to Send Network Request to this User "
 end
 render :layout => 'home'
end

def request_save
 @profile = Profile.find_by_user_id(params[:id])
 @user_network = UserNetwork.new(params[:user_network])
 @user_network.created_at = Time.now
 @user_network.user_id = session[:user].id
 @user_network.friend_id = @profile.user_id
 if @user_network.save
#@profile.update_attributes("network",'1')
  flash[:notice] = "Selected Member was Added to your Friends List"
  redirect_to user_profile_url(:user => @user_network.friend_id) 
 else
  render :action => 'send_request'
 end

end

#method to display the list of all friend of user

def list_friends
  
 @profile = User.find(params[:id]) 
 @network_friends = Array[]
 useradd = UserNetwork.find(:all, :conditions=>["user_id = '#{@profile.id}' AND STATUS = '1'"])
   if !useradd.blank?
     for user in useradd
     @network_friends.push("'"+user.friend_id+"'")
    end
   end
 userfrd = UserNetwork.find(:all, :conditions=>["friend_id = '#{@profile.id}' AND STATUS = '1'"])		
  if !userfrd.blank?
    for user in userfrd
    @network_friends.push("'"+user.user_id+"'")
    end
  end 
  if !@network_friends.blank?
   page = params[:page].blank? ? 1 : params[:page]
   @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@network_friends.join(",")})"]
   end
 render :layout => 'home'

end

def search
@profile = User.find(params[:id])
@list = Array[]
useradd = UserNetwork.find(:all, :conditions=>["user_id = '#{@profile.id}' AND STATUS = '1'"])
 if !useradd.blank?
 for user in useradd
 @list.push("'"+user.friend_id+"'")
 end
 end
userfrd = UserNetwork.find(:all, :conditions=>["friend_id = '#{@profile.id}' AND STATUS = '1'"])		
 if !userfrd.blank?
 for user in userfrd
 @list.push("'"+user.user_id+"'")
 end
 end 
 
if !@list.blank? 
if request.post?
if !params[:user].blank?
 page = params[:page].blank? ? 1 : params[:page]
 @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@list.join(",")}) AND (First_Name LIKE ? OR Last_Name LIKE ? OR City LIKE ? OR Country LIKE ?)",params[:user],params[:user],params[:user],params[:user] ], :order => "Country DESC"
end
end
end

if !params[:value].blank? && !@list.blank?
if params[:value] == "last_login"
 page = params[:page].blank? ? 1 : params[:page]
 @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@list.join(",")})"], :order => "last_login DESC"
elsif params[:value] == "Alphabetical_Order"
 page = params[:page].blank? ? 1 : params[:page]
 @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@list.join(",")})"], :order => "First_Name ASC"
elsif params[:value] == "largest_network"
 page = params[:page].blank? ? 1 : params[:page]
 @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@list.join(",")})"], :order => "network DESC"
end

end

    respond_to do |f|	
    f.html {render :template=>"profile/list_friends", :locals=>{:listt=>@list}}
end

end


def add_friend
   @user = User.find(session[:user].id)
   if @user.network <= 50
     @user_network = UserNetwork.find(:first,:conditions =>["user_id LIKE ? AND friend_id LIKE ?",params[:id],session[:user].id])
     @user_network.status =1
     @user_network.update_attributes(params[:user_network])
     @user.network = @user.network + 1
	   @friend = User.find(params[:id])
	   @friend.network = @friend.network+ 1
	   @friend.update_attributes(params[:friend])
     if @user.update_attributes(params[:user])
     flash[:notice] = "User was Successfully added to your network list"
     else
   	 flash[:notice] = "Unable to add this to your network list."
    end 
	 else
	 flash[:notice] = "You have Reached Your Maximun Netwok List."
	 end
  redirect_to user_profile_url(:user => session[:user].id)
end

def decline_friend
 @user_network = UserNetwork.find(:first,:conditions =>["user_id LIKE ? AND friend_id LIKE ?",params[:id],session[:user].id])
 @user_network.destroy
 flash[:notice] = "User was Deleted from your Network List"
 redirect_to user_profile_url(:user => session[:user].id)
end


#def newprofile
#@profile = User.find(params[:id])
#@list = Profile.find_by_sql("SELECT * FROM profiles
#WHERE user_id
#IN (
#SELECT friend_id
#FROM user_networks
#WHERE user_id = '#{@profile.id}' AND STATUS = '1'
#)OR user_id
#IN (
#SELECT user_id
#FROM user_networks
#WHERE friend_id = '#{@profile.id}' AND STATUS = '1'
#)")
#render :layout => 'home'
#end



end
