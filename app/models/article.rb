require 'net/http'

class Article < ActiveRecord::Base

  #validates_presence_of :title
  validates_presence_of :url
  attr_accessible :classes
  belongs_to :user
  
  before_save :add_title
  before_save :get_article

  def add_title
    if self.title.nil?
      self.url = self.url.split( "?" )[0]
      uri = URI.parse( self.url )
      response = Net::HTTP.get_response( uri )
      while response.code == "301" || response.code == "302"
        response = Net::HTTP.get_response( URI.parse( response.header['location'] ) )
      end
      self.title = response.body.scan(/<(TITLE|title)>(.*)<\/(TITLE|title)>/)[0][1] rescue nil
    end
  end
  
  
  
  def get_article
    if self.first_paragraph.nil? && self.full_text.nil?
      self.url = self.url.split( "?" )[0]
      uri = URI.parse( self.url )
      response = Net::HTTP.get_response( uri )
      while response.code == "301" || response.code == "302"
        response = Net::HTTP.get_response( URI.parse( response.header['location'] ) )
      end
      
      doc = Hpricot(response.body)
      divs = []
      (doc/"body//div").each do |div|
        number_of_p_tags = 0
        (div/"p").each { |p| number_of_p_tags += 1 }
        divs.push( { div => number_of_p_tags } )
      end
      
      div_with_most_p_tags = ""
      number_to_beat = 0
      divs.each do |div_hash|
        div_hash.each do |div, number_of_p_tags|
          if number_of_p_tags > number_to_beat
            div_with_most_p_tags = div
            number_to_beat = number_of_p_tags
          end
        end
      end
      
      self.full_text = (div_with_most_p_tags/"p").to_s
      self.first_paragraph = (div_with_most_p_tags/"p").first.to_s
    end
  end
      
        

  # CSS classes for displaying the article on the frontpage
  def self.classes
  {
    4 => ["venti"],
    2 => ["tall-vertical"],
    3 => ["grande-vertical"],
    1 => ["short"]
  }
  end

end