class BoutiquesController < ApplicationController
  
before_filter :login_required
before_filter :network_list, :session_mail
layout 'home'

 def list
   
 end


end