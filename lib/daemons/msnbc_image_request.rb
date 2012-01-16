require './lib/daemons/request'

class MSNBCImageRequest < Request

"http://api.msnbc.msn.com/documents/getdocuments?contentType=im&maxResults=10&output=xml"
"http://api.msnbc.msn.com/documents/getdocuments?contentType=im&maxResults=10&output=xml"
  
  attr_accessor :base, :articles, :values, :wrappers, :wrapped_values
  
  def initialize
    @articles = []
    @base = "http://api.msnbc.msn.com/documents/getdocuments?"
    @values = {
      #:entities => "*",
      :content_type => "im", # image
      :format => "xml", # it doesn't return well-formed json. motherfuckers.
      :max_results => "10"
    }
    @wrappers = {
      #:entities => "entities=",
      :content_type => "contentType=",
      :format => "output=",
      :max_results => "maxResults="
    }
  end
  
  def wrap_values
    @wrapped_values = {
      :content_type => "#{@wrappers[:content_type]}#{@values[:content_type]}",
      :format => "#{@wrappers[:format]}#{@values[:format]}",
      :max_results => "#{@wrappers[:max_results]}#{@values[:max_results]}"
    }
  end
  
  def generate_query
    @query_string = "#{@base}#{@wrapped_values[:content_type]}&#{@wrapped_values[:max_results]}&#{@wrapped_values[:format]}"
  end
  
  def parse
    @parsed = REXML::Document.new( @response.body )
    @parsed.elements.each('Result/Documents/Document') do |article|
      raw_article = RawArticle.new
      raw_article.title = article.elements["DocTitle"].text
      raw_article.body =  '<img src="' + article.elements["DocUri"].text + '"/>'
      raw_article.url = article.elements["DocUri"].text
      @articles.push( raw_article )
    end
  end
  
  def display
    if @articles.nil?
      puts "no msnbc articles"
    else
      @articles.each do |article|
        puts article.title
        puts article.body
        puts article.url
      end
    end
  end
  
end