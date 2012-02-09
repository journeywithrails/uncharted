class FeedBackController < ApplicationController
  
before_filter :login_required, :except => [:reply, :create_reply, :create, :list, :delete]
before_filter :network_list, :session_mail
layout 'home'  


def index
@profile = User.find(session[:user].id)
@feed_back = FeedBack.new
end

def create
@profile = User.find(session[:user].id)
@feed_back = FeedBack.new(params[:feed_back])
@feed_back.date = Time.now
  if @feed_back.save
   redirect_to :action => 'posted'
  else
   render :action => 'index'
  end
end

def posted
end

#methods for admin Module

def reply
@comment= FeedBack.find(params[:id])
@feed_back = FeedBack.new
@feed_back.user_id = @comment.user_id
render :layout => 'admin'
end

def create_reply

@comment = FeedBack.find(params[:id])
@feed_back = FeedBack.new(params[:feed_back])
    user_mail = {
      :from_user => session[:user].id, 
      :to_user => params[:feed_back][:user_id],
      :subject => "Reply for Comment", 
      :message => params[:feed_back][:Description].gsub("\n", "<br />"),
      :date_sent => Time.now
    }
    @mail = UserMail.new(user_mail)
    if @mail.save
    @user = User.find(user_mail[:to_user]).email
	@comment.update_attribute('status','1')
    flash[:notice] = "Message to #{@user} has been sent"
    redirect_to :action => 'list'
    else
    flash[:notice] = "There was an error while attempting to send your message"
    render :action => 'reply'
	end

end

def show
@feedback = FeedBack.find(params[:id])
render :layout => false
end

def list
@list = FeedBack.find(:all,:conditions=>["status ='0' "])
render :layout=> 'admin'
end

def delete
    FeedBack.find(params[:id]).destroy
    redirect_to :action => 'list'
 end


end
