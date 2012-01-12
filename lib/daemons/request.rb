# REQUIRE
# requrire net/http so that we can make the http get request, and
# require json so that we can parse the result.
require 'net/http'
require 'json'

class Request
  
  # INSTANCE VARIABLES
  # The @response, @parsed, and @articles variables deal with the response from the API.
  # @response holds the raw response, @parsed holds the parsed but still raw response,
  # and @articles is an arry holding the parsed article objects.
  attr_accessor :response, :parsed, :articles
  
  # The @query_string variable, as you might expect, holds the entire query string.
  # This will be used by the get_some method when you actually go forth to make
  # the request.
  attr_accessor :query_string
  
  
  # GET SOME
  # Go forth and make an http get request!
  def get_some
    uri = URI.parse( @query_string )
    @response = Net::HTTP.get_response( uri )
  end
  
end
  