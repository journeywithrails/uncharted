class Emailmailer < ActionMailer::Base

def newmail(fname,tname,email)
@subject              = "You Have Received an new mail form #{fname} "
@body['tname']        =  tname
@body['fname']        =  fname
@recipients           =  email
@from                 = 'support@seasonedadventurer.com'   
end

def network_request(fname,tname,email)
@subject              = " #{fname} sent you a friend request....."
@body['tname']        =  tname
@body['fname']        =  fname
@recipients           =  email
@from                 = 'support@seasonedadventurer.com'   
end


def invite_friend(name,email,comment,sname)
@subject              = " #{sname} has send an Invitation to Register in Seasoned Adventurer"
@body['name']         =  name
@body['comment']      =  comment
@body['sname']        =  sname
@recipients           =  email
@from                 = 'support@seasonedadventurer.com' 
end

def forgotten(name,email,password)
	@subject          = 'Your new password for Seasoned Adventurer '
	@body['name']     = name
    @body['password'] = password
    @recipients       = email
    @from             = 'support@seasonedadventurer.com'
end


end