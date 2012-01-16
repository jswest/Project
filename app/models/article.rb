require 'net/http'

class Article < ActiveRecord::Base

  #validates_presence_of :title
  validates_presence_of :url
  attr_accessible :classes
  belongs_to :user
  
  before_save :add_title
  
  def add_title
    if self.title.nil?  
      uri = URI.parse( self.url )
      response = Net::HTTP.get_response( uri )
      while response.code == "301"
        response = Net::HTTP.get_response( URI.parse( response.header['location'] ) )
      end
      self.title = response.body.scan(/<(TITLE|title)>(.*)<\/(TITLE|title)>/)[0][1]
    end
  end

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