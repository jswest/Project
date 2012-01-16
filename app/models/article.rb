require 'net/http'

class Article < ActiveRecord::Base

  #validates_presence_of :title
  validates_presence_of :url
  belongs_to :user
  
  before_save :add_title
  
  def add_title
    if self.title.nil?  
      uri = URI.parse( self.url )
      response = Net::HTTP.get_response( uri )   
      self.title = response.body.scan(/<(TITLE|title)>(.*)<\/(TITLE|title)>/)[0][1]
    end
  end
  
end