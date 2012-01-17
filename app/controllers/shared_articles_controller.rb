class SharedArticlesController < ApplicationController
  # GET /shared_articles
  # GET /shared_articles.json
  
  #force_ssl
  def index
    @shared_articles = @current_user.received_articles

    respond_to do |format|
      format.html
      format.json { render json: @shared_articles }
    end
  end

  # GET /shared_articles/1
  # GET /shared_articles/1.json
  def show
    @shared_article = SharedArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shared_article }
    end
  end

  # GET /shared_articles/new
  # GET /shared_articles/new.json
  def new
    @shared_article = SharedArticle.new
    
    if params[:article_id].present?
      @article=Article.find(params[:article_id]) rescue nil
    else
      flash.now[:notice] = 'Please enter a valid URL'
    end
    
    if params[:user_id].present?
      @user=User.find(params[:user_id]) rescue nil
    else
      flash.now[:notice] = 'Please enter a valid user'
    end

    respond_to do |format|
      format.html {render :partial => "new"}
      format.json { render json: @shared_article }
    end
  end

  # GET /shared_articles/1/edit
  def edit
    @shared_article = SharedArticle.find(params[:id])
  end

  # POST /shared_articles
  # POST /shared_articles.json
  def create
    @shared_article = SharedArticle.create_share(params)

    respond_to do |format|
      if @shared_article.save
        @article = Article.new
        format.html { render :partial => 'articles/form', notice: 'Article was succesfully shared!' }
        format.json { render json: @shared_article, status: :created, location: @shared_article }
      else
        format.html { render action: "new" }
        format.json { render json: @shared_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shared_articles/1
  # PUT /shared_articles/1.json
  def update
    @shared_article = SharedArticle.find(params[:id])

    respond_to do |format|
      if @shared_article.update_attributes(params[:shared_article])
        format.html { redirect_to @shared_article, notice: 'Shared article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shared_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shared_articles/1
  # DELETE /shared_articles/1.json
  def destroy
    @shared_article = SharedArticle.find(params[:id])
    @shared_article.destroy

    respond_to do |format|
      format.html { redirect_to shared_articles_url }
      format.json { head :ok }
    end
  end
  
  def sent
  end
end
