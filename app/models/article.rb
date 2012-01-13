class Article < ActiveRecord::Base

  #validates_presence_of :title
  validates_presence_of :url
  attr_accessible :classes
  
  belongs_to :user

  # CSS classes for displaying the article on the frontpage
  def self.classes
  [
    "venti",
    "tall",
    "tall",
    "grande-vertical",
    "grande-horizonal",
    "tall",
    "tall"
  ]
  end

end