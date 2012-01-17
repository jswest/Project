require './lib/daemons/raw_article'
require './lib/daemons/nytimes_request'
require './lib/daemons/nytimes_time_massage'

# Loads articles from the NYTimes
def pantalaimon
  
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
    r = NYTimesNewsRequest.new( section )
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
    if !r.response.is_a?( Net::HTTPOK )
      Rails.logger.info "No dice. Connection failed. Aborting..."
      break
    end
    
    # parse and display the response
    Rails.logger.info "Parsing response at #{Time.now}"
    r.parse
    r.display
    
    
    # load the articles into the database
    # there's a wealth of data that we could add, so we can update the article model
    # to include many, many more fields.
    r.articles.each do |article|
      
      # Check if the article is already in the database, using the url as its
      # unique indetifier.
      db_article = Article.find_by_url( article.url )
      if db_article.nil?
        db_article = Article.new
      end
      
      # Create a TimeMassage object to facilitate the comparison between
      # the NYTimes timestamp and ours.
      time_massage = NYTimesTimeMassage.new( article.updated_date )
      
      # Fix the NYTimes timestamp.
      good_nytimes_time = time_massage.fix_nytimes_time
      
      # !If the check article is nil (the article isn't in the database) OR
      # if the article in the database was updated before the nytimes article...
      # Then you can procede to add the article into the database.
      if db_article.updated_at.nil? || db_article.updated_at < good_nytimes_time

        # Create a new SearchRequest object
        sr = NYTimesSearchRequest.new( article.url )
      
        # Create the search request query string
        sr.wrap_values
        sr.generate_query
      
        # Make the query
        sr.get_some
      
        # Break if it fails
        if !sr.response.is_a?( Net::HTTPOK )
          Rails.logger.info "No dice. Search request connection failed. Aborting..."
          break
        end
      
        # Parse and display the response
        Rails.logger.info "Parsing search response at #{Time.now}"
        sr.parse
        sr.display
      
        # Give the article a first paragraph
        article.body = sr.article_body
      
        # Give it the information
        db_article.title = article.title
        db_article.abstract = article.abstract
        db_article.first_paragraph = article.body
        db_article.url = article.url
        db_article.source = "The New York Times"
      
        # Save it! (unless it doesn't have a first paragraph)
        if db_article.first_paragraph.present?
          db_article.save!
          puts "Article saved!"
        end
      
        # Pause for a hot sec so that nytimes doesn't sue us
        sleep 1
      
      end
      
    end
    
    # Pause for a hot sec, so that nytimes doesn't sue us
    sleep 1
    
  end
 
end



 