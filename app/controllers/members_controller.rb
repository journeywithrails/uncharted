class MembersController < ApplicationController
  
before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'

#method for search fields
def search
end

#method for search result
def list
if request.post?
   condition = nil

  if !params[:First_Name].blank?
  statement = "First_Name like '#{params[:First_Name]}' "
  condition = ["First_Name like '#{params[:First_Name]}' "]
  end
  
  if !params[:Last_Name].blank?
    if condition == nil 
    condition = ["Last_Name like '#{params[:Last_Name]}' "]
    statement = "Last_Name like '#{params[:Last_Name]}' "
    else
    add_statement = statement + "AND " + "Last_Name like '#{params[:Last_Name]}'"
    condition = [statement]
    end
  end
  

  
  if !params[:City].blank?
     if condition == nil 
     condition = ["City like '#{params[:City]}' "]
     statement = "City like '#{params[:City]}' "
     else     
     add_statement = statement +"AND " + "City like '#{params[:City]}'"
      condition = [statement]
     end
  end
  
    if !params[:state].blank?
     if condition == nil 
     condition = ["State like '#{params[:state]}' "]
     statement = "State like '#{params[:state]}' "
     else
      statement = statement + "AND " + "State like '#{params[:state]}'"
     condition = [statement] 
     end
  end
  

   if !params[:key_words].blank?
     if condition == nil 
     condition =  ["places_lived LIKE ? OR places_traveled LIKE ? OR personal_interests LIKE ? OR work_life LIKE ? OR future_plans LIKE ?","%#{params[:key_words]}%","#{params[:key_words]}","#{params[:key_words]}","#{params[:key_words]}","#{params[:key_words]}"]
     statement = "places_lived LIKE '#{params[:key_words]}'OR places_traveled LIKE '#{params[:key_words]}' OR personal_interests LIKE '#{params[:key_words]}' OR work_life LIKE '#{params[:key_words]}' OR future_plans LIKE '#{params[:key_words]}'"
      else
     statement=statement+ "AND " +  "City LIKE '#{params[:key_words]}'"
     condition = [statement]
     end
  end
  
    if !params[:user][:industry].blank?
     if condition == nil 
     condition = ["industry like '#{params[:user][:industry]}' "]
     statement = "industry like '#{params[:user][:industry]}' "
     else
       statement = statement +"AND " + "industry like '#{params[:user][:industry]}'"
     condition = [statement] 
     end
  end
  

  
   if params[:user][:status] == '0'
     if condition == nil 
     condition = ["logged_in ='1' "]
     statement = "logged_in ='1' "
     else
     statement = statement+ "AND " + "logged_in ='1'"
     condition = [statement]
     end
  end
  
   if params[:Gender]=='male'
     if condition == nil 
     condition = ["Gender like 'male' "]
     statement = "Gender like 'male' "
     else
       statement = statement + "AND " + "Gender like 'male'"
     condition = [statement]
     end
  end
  
   if params[:Gender]=='female'
     if condition == nil 
     condition = ["Gender like 'female' "]
     statement = "Gender like 'female' "
     else
       statement = statement+ "AND " + "Gender like 'female'"
     condition = [statement] 
     end
  end
  if params[:Gender]=='both'
     if condition == nil        
     condition = ["Gender like 'female' OR Gender like 'male'"]
     statement = "Gender like 'female' OR Gender like 'male'"
     else
       if !params[:key_words].blank?  
      condition = condition
      else
      statement = statement+"AND " + "(Gender like 'female' OR Gender like 'male')"
      condition = [statement] 
     end
     end
  end

  if params[:user][:network] == '0'
	  @list = Array[]
      useradd = UserNetwork.find(:all, :conditions=>["user_id = '#{session[:user].id}' AND STATUS = '1'"])
	  if !useradd.blank?
		for user in useradd
		 @list.push("'"+user.friend_id+"'")
		 end
	  end
 	 userfrd = UserNetwork.find(:all, :conditions=>["friend_id = '#{session[:user].id}' AND STATUS = '1'"])		
	 if !userfrd.blank?
	 for user in userfrd
	 @list.push("'"+user.user_id+"'")
	 end
	 end 
	 if !@list.blank?
    if condition == nil 	
      
    condition = ["id in (#{@list.join(",")}) " ]
    statement = "id in (#{@list.join(",")}) " 
    else
      statement = statement+ "AND " + "id in (#{@list.join(",")})"
    condition = [statement] 
    end
	end
  end
  
  
  if !params[:user][:Country].blank?
    if condition == nil 
      
    condition = ["Country like '#{params[:user][:Country]}' "]
    statement= "Country like '#{params[:user][:Country]}' "
    else
      statement=statement+ "AND " + "Country like '#{params[:user][:Country]}'"
    condition = [statement] 
    end
  end

    if condition != nil
    @list = User.find(:all,:conditions => condition)
    end
	
	if @list.blank?
	respond_to do |f|	
    f.html {render :template=>"members/list", :locals=>{:list=>@list}}
	 end
	
	else
		  respond_to do |f|	
    f.html {render :template=>"members/search", :locals=>{:list=>@list}}
	 end
	end
end
end

def searchin_network

if !params[:user].blank?
   @list = User.find(:all, :conditions =>["First_Name LIKE ? OR Last_Name LIKE ? OR City LIKE ? OR Country LIKE ?", params[:user],params[:user],params[:user],params[:user]])
  respond_to do |f|	
    f.html {render :template=>"profile/list_friends", :locals=>{:list=>@list}}
	 end
	 
	 else
	 redirect_to :controller => 'profile', :action => 'list_friends', :id => session[:user].id
end
end

def last_login
redirect_to :controller => 'profile', :action => 'list_friends', :id => params[:id]
end
def alphabetical
redirect_to :controller => 'profile', :action => 'list_friends', :id => params[:id]
end

end
