require 'cgi'
require 'date'
class UserMailController < ApplicationController
  
before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'


 def index
 render_text 'mail'
 end
 
 
 def show_box
    @mail_box = params[:mail_box]
    @page = params[:page].blank? ? 1 : params[:page]
    respond_to do |f|
	
    f.html {render :template=>"user_mail/mail_container", :locals=>{:message_list=>get_message_list(@mail_box,@page),:mail_box=>@mail_box}}
	
    f.js{render(:update){|page|
        page.replace_html 'mail_list', :partial=>"mail_table", :locals=>{:message_list=>get_message_list(@mail_box,@page), :mail_box=>@mail_box}
        }}
    end
 end
 
  
  def show_message
    message_id = params[:id]
    @mail_box = params[:mail_box]
    @message = UserMail.find(message_id, :conditions => ["to_user = ? OR from_user = ?", session[:user].id, session[:user].id], :include=>[:to_id,:from_id])
    if @mail_box == "inbox"
      @message.update_attribute('user_read','1')
      mail = UserMail.find(:all, :conditions=>["to_user LIKE ? AND user_read LIKE ?",session[:user].id,0])
      session[:mail]= mail.length
    end
    respond_to do |f|
      f.html {render :template=>"user_mail/mail_container", :locals=>{:message_list=>get_message_list(@mail_box,@page), :mail_box=>@mail_box, :message=>@message}}
      f.js {render(:update){|page|
        page.replace_html 'usermail_right', :partial=>'show_message', :locals=>{:message=>@message, :mail_box=>@mail_box}
        page.visual_effect "appear", 'usermail_right'
        }}      
    end
  end
  
  def send_mail
    if !User.find(:first, :conditions=>["email = ? OR id = ?", params[:mail][:to_user],params[:mail][:to_user]])	
    flash[:notice] = "There is no user exists with the given email address"
    redirect_to show_mail_box_url(:user=>session[:user].id, :mail_box=>"inbox")
   else
    user_mail = {
      :from_user => session[:user].id, 
      :to_user => User.find(:first, :conditions=>["email = ? OR id =?", params[:mail][:to_user],params[:mail][:to_user]]).id,
      :subject => params[:mail][:subject],
      :message => params[:mail][:message].gsub("\n", "<br />"),
      :date_sent => Time.now
    }
    @mail = UserMail.new(user_mail)
    if @mail.save
    @user = User.find(user_mail[:to_user]).email
    flash[:notice] = "Message to #{@user} has been sent"
    redirect_to show_mail_box_url(:user=>session[:user].id, :mail_box=>"sent")	
    else
    flash[:notice] = "There was an error while attempting to send your message"
    redirect_to show_mail_box_url(:user=>session[:user].id, :mail_box=>"inbox")
	end
	end
  end
  
  def compose
  @mail = UserMail.new
   @friends= Array[]
  @friends = list_friends(session[:user].id) 
  if !@friends.blank?
  @compose_list = User.find(:all, :conditions => ["id in (#{@network_friends.join(",")})"])
  end
    to_user = params[:to]
    if to_user
      @userinfo = User.find(to_user)
      if !@userinfo
        redirect_to show_mailbox_url(:user=>session[:user].id, :mail_box=>"inbox")
      end
    else 
      @userinfo = nil
    end
    
    respond_to do |f|
      f.html{render}
    end
  end
  
  def delete_message
    mail_box = params[:mail_box]
    message_id = params[:id]
    @message = UserMail.find(message_id, :conditions=>["to_user = ? OR from_user = ?", session[:user].id, session[:user].id])
    if @message
      if mail_box == "inbox"
        @message.update_attribute('to_deleted','1')
        flash[:notice] = "Selected message was deleted from your Inbox."
      else
        @message.update_attribute('from_deleted','1')
         flash[:notice] = "Selected message was deleted from your Sent Mails."
      end
      
      redirect_to show_mail_box_url(:user=>session[:user].id,:mail_box =>mail_box)
    end
  end
    
private
  def get_message_list(mail_box,page)
    case mail_box
    when "inbox"
      #@message_list = UserMail.find(:all, :conditions =>{:to_user => current_user.id, :to_deleted  => "0"}, :include=>:from_id, :order=>"date_sent DESC")
	  
#@message_list=UserMail.find(:all,:conditions =>{:to_user => session[:user].id,:to_deleted  => "0"},:order=>"date_sent DESC")
	   
	  
 @message_list = UserMail.paginate :per_page=>5, :page => page, :conditions =>{:to_user => session[:user].id,:to_deleted => "0"},  :order=>"date_sent DESC"
	  
	  
    when "sent"
	#@message_list=UserMail.find(:all,:conditions =>{:from_user => session[:user].id, :from_deleted  => "0"} ,:order=>"date_sent DESC")
	
   @message_list = UserMail.paginate :per_page=>5, :page=>page, :conditions =>{:from_user => session[:user].id, :from_deleted  => "0"}, :order=>"date_sent DESC"
      #@message_list = UserMail.find(:all, :conditions => {:from_user => current_user.id, :from_deleted => "0"}, :include=>:to_id, :order=>"date_sent DESC")
    end
  end

 

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