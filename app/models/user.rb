class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email
  has_many :saved_articles, :class_name => "SavedArticle"
  has_many :articles
  has_and_belongs_to_many :received_articles, :class_name => "SharedArticle"
  has_many :sent_articles, :class_name => "SharedArticle"
  before_save :format_attributes

  def format_attributes
    self.email = self.email.downcase
  end
end