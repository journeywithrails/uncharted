ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  #map.connect ':controller/service.wsdl', :action => 'wsdl'
  
  map.connect '', :controller => 'home', :action => 'login'
   
  map.resources :users
  map.resource :session
   
   
  map.connect 'home', :controller=>'home', :action=>'index'
  map.connect 'administrator', :controller=>'admin', :action=>'index'
  map.connect 'admin', :controller=>'admin', :action=>'index'
  map.connect 'magazine', :controller=>'magazine', :action=>'index'
  
  #network url maps
  map.connect 'network/:id', :controller=>'network', :action=>'index', :id => @id
   #user url maps
  map.user_profile  "profile/:user", :controller=>'profile', :action=>'profile_show'
  map.user_settings "profile/settings/:user", :controller=>'profile', :action=>'settings'
 
  #event url maps	
  map.events '/events', :controller=>'events', :action=>'index'
  map.suggest_event '/event/suggest', :controller=>'events', :action=>'suggest_event'
  map.post_event '/event/post_event', :controller=>'events', :action=>'post_event'
  map.details '/event/details/:id', :controller => 'events', :action => 'details'
  
  #mail url maps
  map.compose "/:user/mail/compose", :controller=>'user_mail', :action=>'compose'
  map.send_mail "/:user/mail/send", :controller=>'user_mail', :action=>'send_mail'
  map.delete_message "/:user/mail/:mail_box/delete/:id", :controller=>'user_mail', :action=>'delete_message'
  map.compose_to "/:user/mail/compose/:to", :controller=>'user_mail', :action=>'compose'
  map.show_mail_box "/:user/mail/:mail_box", :controller=> 'user_mail', :action=>'show_box'
  map.show_message "/:user/mail/:mail_box/show/:id", :controller=>'user_mail', :action=>'show_message'
  map.compose "/:user/mail/compose", :controller=>'user_mail', :action=>'compose'
  
  #forum url maps
  map.forums "/forum", :controller=>'forum', :action=>'show_categories'
  map.forum_reply "/forum/reply/:id", :controller=>'forum', :action=>'reply'
  map.forum_category "/forum/:category", :controller=>'forum', :action=>'list_threads'
  map.new_forum_post "/forum/:category/new", :controller=>'forum', :action=>'new_post'
  map.add_new_forum_post "/forum/:category/new_post", :controller=>'forum', :action=>'add_post'
  map.show_forum_posts "/forum/:category/:id/:thread", :controller=>'forum', :action=>'show_posts'
  map.new_forum_reply "/forum/:category/:id/:thread/reply", :controller=>'forum', :action=>'new_reply'
  map.post_forum_reply "/forum/:category/:id/:thread/post_reply", :controller=>'forum', :action=>'post_reply'
  
  #products url maps  
  map.product_details  "product/:id", :controller=>'boutiques', :action=>'details'
  
  map.connect '/stats/:action', :controller => 'sitealizer'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
