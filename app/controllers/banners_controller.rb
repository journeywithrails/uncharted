class BannersController < ApplicationController
   before_filter :authorizeadmin
  
  layout 'admin'
  
 def index
  @banner = Banner.find(1)  
 end

 def list
  @banner = Banner.find(:all)
 end 
 
 def new
 @banner = Banner.new
 end

def create
  @banner = Banner.new(params[:banner])
  @banner.created_at = Time.now
   @banner.edited_at = Time.now
 if @banner.save
  flash[:notice]= "New Banner was successfully created."  
  redirect_to :action => 'index', :id => 1
 else
  render :action => 'new'
 end
 end 
 
 def edit
   @banner = Banner.find(1)
   end
 
 def update
   @banner = Banner.find(1)
   @banner.edited_at = Time.now
  if @banner.update_attributes(params[:banner])
    flash[:notice] = "Banner was successfully updated"
    redirect_to :action => 'index', :id => 1
    else
      render :action => 'index'
      end   
   end
end
