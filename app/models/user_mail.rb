class UserMail < ActiveRecord::Base
  belongs_to :to_id, :class_name => "User", :foreign_key => "to_user"
  belongs_to :from_id, :class_name => "User", :foreign_key => "from_user"
  
  validates_presence_of     :to_user, :subject, :message
  
  after_create :send_notification
  
  def send_notification  
  mail_to = User.find(self.to_user)
  mail_from = User.find(self.from_user)
  @settings = UserSetting.find_by_user_id(self.to_user)
  
  if @settings.new_mail==1
  Emailmailer.deliver_newmail(mail_from.First_Name,mail_to.First_Name,mail_to.email)
  end
  
  end
  
  
  
  
end
