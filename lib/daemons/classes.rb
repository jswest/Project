require 'net/http'
require 'json'

class Raw_Article
  attr_accessor :section, :title, :abstract, :url, :byline, :published_date, :kicker, :subhead, :material_type_facet, :des_facet, :org_facet, :per_facet, :geo_facet
  
end



class NewsRequest
  
  
  attr_accessor :response, :articles
  attr_accessor :base
  attr_accessor :version, :source, :section, :response_key, :api_key


  def initialize( section )
    @version = "v3"
    @source = "all"
    @section = section
    @response_type = "json"
    @api_key = "109aa7fe33895f3a2814af120e28fdc7:0:56122124"
    @base = "http://api.nytimes.com/svc/news/#{@version}/content/#{@source}/#{@section}/.#{@response_type}?api-key=#{@api_key}"
    @articles = []
  end


  def create_query_string
    @query_string = @base
  end


  def get_some
    uri = URI.parse( @query_string )
    @response = Net::HTTP.get_response( uri )
  end
  
  
  def parse
    JSON.parse(@response.body)["results"].each do |result|
      a                     = Raw_Article.new
      a.section             = result['section']
      a.title               = result['title']
      a.abstract            = result['abstract']
      a.url                 = result['url']
      a.byline              = result['byline']
      a.published_date      = result['published_date']
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
  
  def display
    @articles.each do |article|
      puts article.section
      puts article.kicker
      puts article.title
      puts article.subhead
      puts article.byline
      puts article.abstract
      puts article.published_date
      puts article.material_type_facet
      print "#{article.des_facet}; #{article.org_facet}; #{article.per_facet}; #{article.geo_facet}"
      puts
      puts
      puts
    end
  end
  
  def just_do_it
    self.create_query_string
    self.get_some
    self.parse
    self.display
  end
  
end

r = NewsRequest.new("nytfrontpage")
r.just_do_it