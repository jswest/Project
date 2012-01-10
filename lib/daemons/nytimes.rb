require './lib/daemons/classes'

def load_articles
  
  # GABE IS MAGIC
  # This ensures that I can access the database.
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!
  
  # PICK SECTIONS
  # Here are sections from which we're grabbing articles
  sections = [
    "arts",
    "books",
    "business",
    "magazine",
    "news",
    "science",
    "washington",
    "opinion"
  ]
  
  # ACCESS THE API
  
  # For each of the sections create a request object and push it to the requests variable
  requests = []
  sections.each do |section|
    r = NewsRequest.new( section )
    requests.push( r )
  end

  # Tell the logger what's we're about to do.
  Rails.logger.info "Grabbing nytimes articles at #{Time.now}.\n"
  
  # Try to access the API for each of the requests (sections)
  requests.each do |r|
    
    # Create the query string
    r.create_query_string
    
    # Make the query
    r.get_some
    
    # break if it fails
    unless r.response.is_a?( Net::HTTPOK )
      Rails.logger.info "No dice. Connection failed. Aborting..."
      break
    end
    
    # parse the response
    Rails.logger.info "Parsing response at #{Time.now}"
    r.parse
    
    # load the articles into the database
    # there's a wealth of data that we could add, so we can update the article model
    # to include many, many more fields.
    r.articles.each do |article|
      
      # Create the new article for the database
      db_article = Article.new
      
      # Give it the information
      db_article.title = article.title
      db_article.abstract = article.abstract
      db_article.url = article.url
      
      # Save it!
      db_article.save!
    end
    
    # Pause for a hot sec, so that nytimes doesn't sue us
    sleep 1
    
  end
  
end
    
    
    
    
  