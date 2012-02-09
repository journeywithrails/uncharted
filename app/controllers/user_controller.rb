require 'date'

class UserController < ApplicationController

before_filter :authorizeadmin  
layout 'admin'


def index
redirect_to :action => 'list'
end



 def list
   page = params[:page].blank? ? 1 : params[:page]
   @users = User.paginate :per_page=>5, :page =>page, :conditions =>("status = 0 ")
   @total = User.find(:all,:conditions =>("status = 0 "))
 end

def search
if request.post?
@users = User.paginate :page => params[:page],:per_page=>5, :conditions => [ "First_Name LIKE ?  OR email LIKE ? OR birthday LIKE '#{params[:query]}' AND (status = 0)",params[:query],params[:query]]
@total = @users
end
respond_to do |f|	
    f.html {render :template=>"user/list", :locals=>{:users=>@users, :total => @total}}
end
end

def profile
 @profile = User.find(params[:id])
end

def profile_edit
 @user = User.find(params[:id])
end

def profile_update
 @user = User.find(params[:id])
 @user.updated_at = Time.now
 if @user.update_attributes(params[:user])
 flash[:notice]= "User Details Successfully Updated."
 redirect_to :action => 'list'
 else
 render :action => 'profile_edit'
 end
end



def delete
 @user = User.find(params[:id])
 @user.status = 1
 @user.update_attributes(params[:user])
 flash[:notice] = "User was Successfully Deleted."
 redirect_to :action => 'list'
end


def new
@user = User.new
end


def create
    @user = User.new(params[:user])
	@user.created_at = Time.now
	if @user.save
    @settings = UserSetting.new(:user_id=>@user.id)
    @settings.save
	flash[:notice] = "New User was Successfully Created"
	redirect_to :controller=>'user', :action => 'list' 
	else
	#rescue ActiveRecord::RecordInvalid
	render :action => 'new'
	end  	
end















end
