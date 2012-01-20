class FrontPageController < ApplicationController




  def index
    @front_page_articles = generate_front_page_articles
    @shared_article = SharedArticle.new

    respond_to do |format|
      format.html
    end
  end

  def update_front_page
    deleted_article = Article.find( params[:id] )
    @front_page_articles.delete( deleted_article )
    @front_page_articles.push( {
      :shared_by => "The New York Times",
      :article => Article.where( :first_paragraph.present? ).sample,
      :classes => "tall nytimes tall-nytimes"
    } )
    render :partial => "front_page", :collection => @front_page_articles, :as => :article
  end

  private

  def generate_front_page_articles
    
    # Make an empty front_page_articles array
    front_page_articles = []

    # If there are three or fewer received articles, just make those the received articles
    # for the front page
    if @current_user.received_articles.length <= 3
      received_articles = @current_user.received_articles
    
    # If there are more than that, get three random ones, ensuring no duplicates
    else
      received_articles = []
      while received_articles.length < 3
        pool = @current_user.received_articles
        rando = rand( pool.length )
        received_articles.push( pool[rando] )
        pool.delete_at( rando )
      end
    end
    
    sizes = [ 4, 3, 2, 1, 1, 1 ]
    if received_articles.any?
      received_articles.each_with_index do |received_article, index|
        push_to_front_page_articles = true
        received_articles.each_with_index{ |ca, index| push_to_front_page_articles = false if ca.article.title == received_article.article.title && ca != received_article }    
        logger.debug "Loop #{index}"
        if push_to_front_page_articles
          logger.debug "push"
          front_page_articles.push( {
            :shared_by => received_article.shared_by.firstname,
            :article => received_article.article,
            :classes => "shared #{Article.classes[sizes.first].first}",
            :size => sizes.first
          } )
          sizes.delete_at( 0 )
        else
          logger.debug "no push"
        end
      end
    end # end while
    
    
    # Make the pool of potential nytimes articles
    pool = Article.find_all_by_source( "The New York Times" )  
    while front_page_articles.length < 5 do
      rando = rand( pool.length )
      article = pool[rando]
      pool.delete_at( rando )
      front_page_articles.push( {
        :shared_by => article.source,
        :article => article,
        :classes => "nytimes #{Article.classes[sizes.first].first}",
        :size => sizes.first
      } )
      sizes.delete_at( 0 )
    end
    msnbc_articles = Article.find_all_by_source( "MSNBC" )
    while front_page_articles.length < 6 do
      article = msnbc_articles.sample
      front_page_articles.push( {
        :shared_by => article.source,
        :article => article,
        :classes => "msnbc #{Article.classes[sizes.first].first}",
        :size => sizes.first
      } )
    end
    

    return front_page_articles
  end

end
