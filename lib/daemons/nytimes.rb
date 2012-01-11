require './lib/daemons/classes'
require './lib/daemons/time_massage'

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
      
      # Check if the article is already in the database, using the url as its
      # unique indetifier.
      check_article = Article.find_by_url( "article.url" )
      
      # Create a TimeMassage object to facilitate the comparison between
      # the NYTimes timestamp and ours.
      time_massage = TimeMassage.new( article.updated_date )
      
      # Fix the NYTimes timestamp.
      good_nytimes_time = time_massage.fix_nytimes_time
      
      # !If the check article is nil (the article isn't in the database) OR
      # if the article in the database was updated before the nytimes article...
      # Then you can procede to add the article into the database.
      if check_article.nil? || check_article.updated_at < good_time.fix_nytimes_time

        # Create a new SearchRequest object
        sr = SearchRequest.new( article.url )
      
        # Create the search request query string
        sr.wrap_values
        sr.generate_query
      
        # Make the query
        sr.get_some
      
        # Break if it fails
        unless sr.response.is_a?( Net::HTTPOK )
          Rails.logger.info "No dice. Search request connection failed. Aborting..."
          break
        end
      
        # Parse the response
        Rails.logger.info "Parsing search response at #{Time.now}"
        sr.parse
      
        # Give the article a first paragraph
        article.body = sr.article_body
      
        # Create the new article for the database
        db_article = Article.new
      
        # Give it the information
        db_article.title = article.title
        db_article.abstract = article.abstract
        db_article.full_text = article.body
        db_article.url = article.url
      
        # Save it!
        db_article.save!
      
        # Pause for a hot sec so that nytimes doesn't sue us
        sleep 1
      
      end
      
    end
    
    # Pause for a hot sec, so that nytimes doesn't sue us
    sleep 1
    
  end
  
end

 