class User < ActiveRecord::Base
  
  validates_presence_of :email, :firstname, :lastname
  validates_uniqueness_of :email
  
end
