class UserNetwork < ActiveRecord::Base

after_create :send_notification

def send_notification

request_from = User.find(self.user_id)
request_to = User.find(self.friend_id)
@settings = UserSetting.find_by_user_id(self.friend_id)
  if @settings.network_requests==1
  Emailmailer.deliver_network_request(request_from.First_Name,request_to.First_Name,request_to.email)
  end


end

end
