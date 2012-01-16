require './lib/daemons/msnbc_image_request'

def kaisa
  
  # GABE IS MAGIC
  # This ensures that I can access the database.
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!
  
  # Create the new request
  mr = MSNBCImageRequest.new
  
  # Wrap the values, generate the query string, and then make the http get request
  mr.wrap_values
  mr.generate_query
  mr.get_some
  
  # If the request isn't okay, abort the request.
  if !mr.response.is_a?( Net::HTTPOK )
    Rails.logger.info "No dice. Connection failed. Aborting..."
    puts "No dice. Connection failed. Aborting..."
  
  # If the response is okay, do your thang.
  else  
    
    # Parse the response
    mr.parse
    
    # for each of the articles in the request object...
    mr.articles.each do |article|
      
      # Either make a new Article object or find the old one
      db_article = Article.find_by_url( article.url )
      db_article = Article.new if db_article.nil?

      # Set the values of thea article
      db_article.title = article.title
      db_article.first_paragraph = article.body
      db_article.url = article.url
      
      # Save it!
      db_article.save!
      Rails.logger.info "Article Saved!"
      
    end
    
  end
  
end