class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email
  has_and_belongs_to_many :shared_articles, :uniq => true
  
end
