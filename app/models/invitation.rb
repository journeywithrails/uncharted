class Invitation < ActiveRecord::Base
validates_presence_of   :name,:email,:reason
end
