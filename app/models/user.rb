class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  validates_presence_of :email, :password, :on => :create
  validates_uniqueness_of :email
  has_many :saved_articles, :class_name => "SavedArticle"
  has_many :articles
  has_and_belongs_to_many :received_articles, :class_name => "SharedArticle"
  has_many :sent_articles, :class_name => "SharedArticle", :foreign_key => "shared_by"
  has_many :initiated_friendships, :class_name => "Friendship"
  has_many :initiated_friends, :through => :initiated_friendships, :foreign_key => "user_id", :source => :user
  has_many :received_friendships, :class_name => "Friendship"
  has_many :received_friends, :through => :received_friendships, :foreign_key => "friend_id", :source => :user
  before_save :format_attributes

  def format_attributes
    self.email = self.email.downcase
  end

  def friends
    all_friends = []
    self.initiated_friendships.each{|f| all_friends << f.friend} #if confirmed
    self.received_friendships.each{|f| all_friends << f.user}    #if confirmed
    all_friends
  end
end
