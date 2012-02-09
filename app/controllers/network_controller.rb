class NetworkController < ApplicationController
before_filter :login_required
before_filter :network_list, :session_mail

layout 'home'

def index   
 @profile = User.find(params[:id]) unless params[:id].blank?
 @friends= Array[]
 @friends = list_friends(@profile.id) 
   if !@friends.blank?
   page = params[:page].blank? ? 1 : params[:page]
   @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@network_friends.join(",")})"]
   end   
end  
  
def search
 @profile = User.find(params[:id]) unless params[:id].blank?
 @friends= Array[]
 @friends = list_friends(@profile.id) 
 if !@friends.blank?   
   if params[:value] == "last_login"
     order =  "last_login DESC"
   elsif  params[:value] == "Alphabetical_Order"
     order = "First_Name ASC"
  elsif params[:value] == "largest_network"
     order = "network DESC"
   end
  page = params[:page].blank? ? 1 : params[:page]
  @list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@friends.join(",")})"],:order => order 
   end 
   respond_to do |f|	
    f.html {render :template=>"network/index", :locals=>{:listt=>@list}}
  end 
end

def search_friend
@profile = User.find(params[:id]) unless params[:id].blank?
@friends= Array[]
@friends = list_friends(@profile.id) 
 if request.post? && !@friends.blank?   
page = params[:page].blank? ? 1 : params[:page]
@list = User.paginate :per_page=>20, :page => page, :conditions => ["id in (#{@friends.join(",")}) AND (First_Name LIKE ? OR Last_Name LIKE ?)","%#{params[:user]}%","%#{params[:user]}%"]
else
  @message = "Your search found no result" 
end
   respond_to do |f|	
    f.html {render :template=>"network/index", :locals=>{:listt=>@list}}
  end  
   

end
  
private

def list_friends(id)
 params[:pid] = id
@network_friends = Array[]
 useradd = UserNetwork.find(:all, :conditions=>["user_id Like ? AND STATUS = '1'",params[:pid]])
   if !useradd.blank?
     for user in useradd
     @network_friends.push("'"+user.friend_id+"'")
    end
   end
  userfrd = UserNetwork.find(:all, :conditions=>["friend_id Like ? AND STATUS = '1'",params[:pid]])		
  if !userfrd.blank?
    for user in userfrd
    @network_friends.push("'"+user.user_id+"'")
    end
  end 
return @network_friends

end
  
end
