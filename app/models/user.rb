class User < ActiveRecord::Base 

usesguid

#acts_as_ferret 

  belongs_to :event
  belongs_to :feed_back
  belongs_to :admin_user
  #has_one :profile  
  has_one :user_settings,:class_name => "UserSetting"
  attr_accessor :password
  

  
  INDUSTRY_TYPES = [
				[ "Software, Hardware, EDP", "Software, Hardware, EDP" ],
				[ "Sales", "Sales"],
				[ "Marketing & Communications", "Marketing & Communications" ],
				[ "Advertising, DM, PR, MR "],
				[ "Entertainment / Media / Journalism", "Entertainment / Media / Journalism"],
				[ "Human Resource, Admin & Recruitment", "Human Resource, Admin & Recruitment"],
				[ "Purchase/ Supply Chain", "Purchase/ Supply Chain"],
				[ "Finance & Accounts", "Finance & Accounts"],
				[ "Banking", "Banking"],[ "Insurance", "Insurance"],[ "Financial Services", "Financial Services"],
				[ "Legal/ Law", "Legal/ Law"],[ "Production/ Engg/ R&D", "Production/ Engg/ R&D"],
				[ "Pharmaceutical/ Biotechnology", "Pharmaceutical/ Biotechnology"],
				[ "Call Centre, BPO, Customer Service", "Call Centre, BPO, Customer Service"],
				[ "Telecom/ ISP", "Telecom/ ISP"],[ "Health Care", "Health Care"],
				[ "Hotels/ restaurants", "Hotels/ restaurants"],[ "Travel/ Airlines", "Travel/ Airlines"],
				[ "Retail Chains", "Retail Chains"],[ "Distribution & Delivery/ Courier", "Distribution & Delivery/ Courier"],
				[ "Export/ Import", "Export/ Import"],[ "Senior Management", "Senior Management"],
				[ "Oil & Gas", "Oil & Gas"],[ "Construction", "Construction"],
				[ "Others", "Others"]
				]
  
  	YEAR_TYPES = [[],[1965],[1966],[1967],[1968],[1969],[1970],[1971],[1972],[1973],[1974],[1975],[1976],[1977],[1978],[1979],[1980],[1981],[1982],[1983],[1984],[1985]]
	
	
#validations----------------------------------------------------------------------	
	
  validates_confirmation_of :password,                   :if => :password_required?  
  validates_length_of       :password, :within => 6..15, :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required? 
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of 	:email
  validates_format_of       :email ,:with => /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,3}$/ ,:message => "Check your Email format, it should be in the format xyz@domain.co "
  validates_uniqueness_of    :email, :case_sensitive => false
  validates_presence_of      :First_Name,:Last_Name,:City,:Country,:birthday,:primary_residence,:email
  validates_file_format_of :profile_image, :in => ["gif", "jpg"]
  validates_filesize_of :profile_image, :in => 1.kilobytes..500.kilobytes
 
   file_column :profile_image, :magick => {
   #:geometry => "555x525!",
   :versions => {:main => "250x375!",:medium => "100x150!",:thumbnail => "80x120!"}  
  } 
  
  before_save :encrypt_password

  
      
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil	
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  
    def self.generate_and_mail_new_password(email)
     result = Hash.new
     if not email.blank? 
      user = self.find_by_email(email)
      if user.blank?
        result['flash'] = 'forgotten_notice'
        result['message'] = 'Could not find any user with this e-mail address'
        return result
      end    
    else       
      return result
    end
    new_password = User.random_password(8)
    user.password = new_password
	user.password_confirmation = new_password

     begin
      if Emailmailer.deliver_forgotten(user.First_Name,user.email,new_password) and user.save!
       # if EmailMailer.deliver_forgotten(user.username, user.email, new_password) 
        result['flash'] = 'login_confirmation'
        result['message'] = 'A new password has been e-mailed to ' + user.email
      else
        result['flash'] = 'forgotten_notice'
        result['message'] = 'Could not create a new password'
      end
    rescue Exception => e
      if e.message.match('getaddrinfo: No address associated with nodename')
        result['flash'] = 'forgotten_notice'
        result['message'] = "The mail server settings in the environment file are incorrect. Check the installation instructions to solve this problem. Your password hasn't changed yet."
      else
        result['flash'] = 'forgotten_notice'
        result['message'] = e.message + ".<br /><br />This means either your e-mail address or template's configuration for e-mailing is invalid. Please contact the administrator or check the installation instructions. Your password hasn't changed yet."
      end
    end

    # finally return the result
    return result
  end 
	
	
	def self.random_password(len)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    random_password = ''
    1.upto(len) { |i| random_password << chars[rand(chars.size-1)] }
    return random_password
    end

  #---------------------------------------------
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = encrypt(password)
    end

	
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    


end
