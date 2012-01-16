require './lib/daemons/msnbc_image_request'

def kaisa
  
  # GABE IS MAGIC
  # This ensures that I can access the database.
  require File.dirname(__FILE__) + "/../../config/application"
  Rails.application.require_environment!
  
  # Create the new request, build it, then execute it
  mr = MSNBCImageRequest.new
  mr.wrap_values
  mr.generate_query
  mr.get_some
  if !mr.response.is_a?( Net::HTTPOK )
    Rails.logger.info "No dice. Connection failed. Aborting..."
    puts "No dice. Connection failed. Aborting..."
  else  
    mr.parse
    mr.articles.each do |article|
      db_article = Article.find_by_url( article.url )
      db_article = Article.new if db_article.nil?
      puts "Made a new article"    
      db_article.title = article.title
      puts article.title
      db_article.first_paragraph = article.body
      puts article.body
      db_article.url = article.url
      puts article.url
      db_article.save!
    end
  end
  
end