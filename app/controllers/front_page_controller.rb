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
    front_page_articles = []
    received_articles = @current_user.received_articles.limit(3)
    sizes = [ 4, 3, 2, 1, 1, 1 ]
    if received_articles.any?
      received_articles.each do |received_article|
        front_page_articles.push( {
          :shared_by => received_article.shared_by.firstname,
          :article => received_article.article,
          :classes => "shared",
          :size => sizes.first
        } )
        sizes.delete_at( 0 )
      end
    end
    nytimes_articles = Article.find_all_by_source( "The New York Times" )
    while front_page_articles.length < 7 do
      article = nytimes_articles.sample
      front_page_articles.push( {
        :shared_by => article.source,
        :article => article,
        :classes => "nytimes",
        :size => sizes.first
      } )
      sizes.delete_at( 0 )
    end
    msnbc_articles = Article.find_all_by_source( "MSNBC" )
    while front_page_articles.length < 8 do
      article = msnbc_articles.sample
      front_page_articles.push( {
        :shared_by => article.source,
        :article => article,
        :classes => "short msnbc"
      } )
    end
    

    return front_page_articles
  end

end
