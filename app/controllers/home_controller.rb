class HomeController < ApplicationController
  
  
before_filter :login_required, :except => [:login, :login_problem, :continue]
before_filter :network_list, :session_mail
layout 'home' 


def index
   @userinfo = User.find(:first, :conditions=>{:id=>params[:id]})
    if @userinfo == nil
      flash[:notice] = "That user dosn't exist in our database"
    end
end

def edit
@profile=Profile.find_by_user_id(params[:id])
end


def update
@profile = Profile.find_by_user_id(params[:id])
if @profile.update_attributes(params[:profile])
flash[:notice]="User Details were Successfully Updated"
redirect_to user_profile_url(:user => session[:user].id) and return 
else
render :action => 'edit'
end
end


#
def login
   session[:user] = nil
   if request.post?
   if session[:user] = User.authenticate(params[:email],params[:password])
      User.update(session[:user].id,{'last_login' => Time.now , 'logged_in' => 1 } )
      flash[:notice] = "Welcome " + session[:user].First_Name.humanize+".."
   redirect_to user_profile_url(:user => session[:user].id) and return   
   else
   flash[:notice] = "Invalid Email Address and Password."
   end
   end  
  render :layout => false
end
 
#  
def logout
  user = User.find(params[:id])
 if user.update_attribute('logged_in','0')
   session[:user]=nil
   session[:mail]=nil
   session[:cart] = nil
  end
   redirect_to :action => 'login'
end
 
 
# 
def login_problem 
   if request.post?     
     result = User.generate_and_mail_new_password(params[:email])
     if result['flash'] == 'forgotten_notice'
     flash.now[:forgotten_notice] = result['message']
	 else
	 flash[:login_confirmation] = result['message']
     redirect_to(:action => 'continue') and return
     end
  end
 render :layout => false
end


def continue
render :layout => false
end

 

 
 
#method to display FAQ's
def FAQ
 
end 
 
 
#method to Invite an new Friend 
def invite_new_member
 @invitation = Invitation.new
end
 
#method to save the Deatils 
def create_member
    email = User.find_by_email(params[:invitation][:email])
	if email.blank?
    @invitation =Invitation.new(params[:invitation])
	@invitation.date=Time.now
	@invitation.user_id = session[:user].id
    if @invitation.save
	begin
    Emailmailer.deliver_invite_friend(@invitation.name,@invitation.email,@invitation.comment,session[:user].First_Name)
	flash[:notice] = "Your Comment and Application had been Mailed to your Friend."
	redirect_to :controller =>"home", :action => 'request_sucess', :email => @invitation.email
	end
    else    
    render :action => 'invite_new_member' 
   end
   else
   flash[:notice] = "This User Already Registered in the Website"
   render :action => 'invite_new_member' 
   end
end

#method to display mail has been send
def request_sucess
@email = params[:email]
end
 
 
end
