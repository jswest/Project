# REQUIRE
# net/http so that we can make a get request of the nytimes api
# json so that we can parse the result.
require 'net/http'
require 'json'


# RAW ARTICLE CLASS
# This class creates a RawArticle object, whose function is to hold all of the
# raw information we get from the nytimes API.
class RawArticle
  attr_accessor :section, :title, :abstract, :body, :url, :byline, :published_date, :updated_date, :kicker, :subhead, :material_type_facet, :des_facet, :org_facet, :per_facet, :geo_facet
  
end



# NEWS REQUEST CLASS
# This class creates a NewsRequest object, whose function is to make a request from
# the NYTimes NewsWire API.
class NewsRequest
  
  # INSTANCE VARIABLES
  # The response and articles variables deal with the response from the API.
  # @response holds the raw response, @articles holds the parsed articles.
  attr_accessor :response, :articles
  
  # These hold the various changable portions of the query string. All except @section have
  # default values. @section must be passed in on creation of the object
  attr_accessor :version, :source, :section, :response_key, :api_key

  
  # INITIALIZE
  # Sets the default values, sets the @section variable, and lets everyone know that articles
  # is going to be an array.
  def initialize( section )
    @version = "v3"
    @source = "all"
    @section = section
    @response_type = "json"
    @api_key = "109aa7fe33895f3a2814af120e28fdc7:0:56122124"
    @articles = []
  end

  
  # CREATE THE QUERY STRING
  def create_query_string
    @query_string = "http://api.nytimes.com/svc/news/#{@version}/content/#{@source}/#{@section}/.#{@response_type}?api-key=#{@api_key}"
  end

  
  # GET SOME
  # Go forth and make a Get request!
  def get_some
    uri = URI.parse( @query_string )
    @response = Net::HTTP.get_response( uri )
  end
  
  
  # PARSE IT
  # This will parse out the JSON response from the @response variable.
  # It then makes an instance of the RawArticle class and shoves the data
  # in there. The @articles instance variables contains these objects.
  def parse
    JSON.parse(@response.body)["results"].each do |result|
      a                     = RawArticle.new
      a.section             = result['section']
      a.title               = result['title']
      a.abstract            = result['abstract']
      a.url                 = result['url']
      a.byline              = result['byline']
      a.published_date      = result['published_date']
      a.updated_date        = result['updated_date']
      a.material_type_facet = result['material_type_facet']
      a.kicker              = result['kicker']
      a.subhead             = result['subheadline']
      a.des_facet           = result['des_facet']
      a.org_facet           = result['org_facet']
      a.per_facet           = result['per_facet']
      a.geo_facet           = result['geo_facet']
      @articles.push( a )
    end
  end
  
  
  # DISPLAY
  # In case you want to print out the articles in the terminal.
  def display
    @articles.each do |article|
      puts article.section
      puts article.kicker
      puts article.title
      puts article.subhead
      puts article.byline
      puts article.abstract
      puts article.published_date
      puts article.updated_date
      puts article.material_type_facet
      print "#{article.des_facet}; #{article.org_facet}; #{article.per_facet}; #{article.geo_facet}"
      puts
      puts
      puts
    end
  end
  
  
  # JUST DO IT
  # If you want to do everything in the terminal.
  # Mostly for debugging.
  def just_do_it
    self.create_query_string
    self.get_some
    self.parse
    self.display
  end
  
end



# SEARCH REQUEST CLASS
# This class creates a SearchRequest object, whose function is to make a request a
# specific article from the NYTimes Search API.
class SearchRequest
  
  
  # INSTANCE VARIABLES
  # The full query contains the full query string. The base contains the base of the query string,
  # generally the http address without any of the params. The values contain the actual values of the params,
  # and the wrappers contain the odd surrounding text for the values to make the string an actual query
  # string. The URI and response variables hold the net/http parsed uri and the response from the server
  # being queried.
  attr_accessor :full_query, :base, :values, :uri, :response, :article_body
  
  
  # INITIALIZER
  # sets the default value of the instance variables
  def initialize( url )
    
    # values
    @base = "http://api.nytimes.com/svc/search/v1/article?"
    @values = {
      :format       => "json",
      :query_string => url,
      :rank         => "newest",
      :api_key      => "f8300a015bf72b44258c431610109fcd:6:56122124" 
    }
    
  end
  
  
  # WRAP VALUES
  # This wrapps the values in the appropraite parts of the query string.
  def wrap_values
    @wrapped_values = {
      :format => "format=#{@values[:format]}&",
      :query_string => "query=url:#{@values[:query_string]}&",
      :rank => "rank=#{@values[:rank]}&",
      :api_key => "api-key=#{@values[:api_key]}"
    }
  end
  
  
  # GENERATE THE FULL QUERY
  # This generates a full query by looping over the values and wrappers variables
  # and adding them to the full_query variable.
  def generate_query
    
    # set up for the loop
    @full_query = @base
    @full_query += @wrapped_values[:format] + @wrapped_values[:query_string] + @wrapped_values[:rank] + @wrapped_values[:api_key]
    
  end
     
  
  # GET SOME
  # Go forth and make your http get request!   
  def get_some
    @uri = URI.parse( @full_query )
    @response = Net::HTTP.get_response( @uri )
    puts @response
  end
  
  # PARSE
  # This parses the response and saves the response in the @article_body variable.
  def parse
    
    # parse the response...
    JSON.parse(@response.body)["results"].each do |result|
      
      # store the first paragraph
      @article_body = result['body']
    
    end
    
  end

end


