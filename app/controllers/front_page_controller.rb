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
    if received_articles.any?
      received_articles.each do |received_article|
        front_page_articles.push( {
          :shared_by => received_article.shared_by.firstname,
          :article => received_article.article,
          :classes => "tall shared"
        } )
      end
    end
    nytimes_articles = Article.where( :first_paragraph.present? )
    while front_page_articles.length < 7 do
      article = nytimes_articles.sample
      front_page_articles.push( {
        :shared_by => "The New York Times",
        :article => article,
        :classes => "tall nytimes tall-nytimes"
      } )
    end

    return front_page_articles
  end

end
