class RegistrationController < ApplicationController



def index
@user = User.new
end

def create
    @user = User.new(params[:user])
	@user.created_at=Time.now
    if @user.save
	    @settings = UserSetting.new(:user_id=>@user.id)
        @settings.save
	 flash[:notice] = "Thanks for signing up! Please Login!"
	 redirect_to :controller =>"home", :action => 'login'
     else    
    render :action => 'index' 
	end
end


end
