class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email
  has_and_belongs_to_many :shared_articles, :uniq => true
  
end
