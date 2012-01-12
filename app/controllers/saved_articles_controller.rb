class SavedArticlesController < ApplicationController
  # GET /saved_articles
  # GET /saved_articles.json
  def index
    @saved_articles = SavedArticle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @saved_articles }
    end
  end

  # GET /saved_articles/1
  # GET /saved_articles/1.json
  def show
    @saved_article = SavedArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saved_article }
    end
  end

  # GET /saved_articles/new
  # GET /saved_articles/new.json
  def new
    @saved_article = SavedArticle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saved_article }
    end
  end

  # GET /saved_articles/1/edit
  def edit
    @saved_article = SavedArticle.find(params[:id])
  end

  # POST /saved_articles
  # POST /saved_articles.json
  def create
    @saved_article = SavedArticle.new(params[:saved_article])

    respond_to do |format|
      if @saved_article.save
        format.html { redirect_to @saved_article, notice: 'Saved article was successfully created.' }
        format.json { render json: @saved_article, status: :created, location: @saved_article }
      else
        format.html { render action: "new" }
        format.json { render json: @saved_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /saved_articles/1
  # PUT /saved_articles/1.json
  def update
    @saved_article = SavedArticle.find(params[:id])

    respond_to do |format|
      if @saved_article.update_attributes(params[:saved_article])
        format.html { redirect_to @saved_article, notice: 'Saved article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @saved_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_articles/1
  # DELETE /saved_articles/1.json
  def destroy
    @saved_article = SavedArticle.find(params[:id])
    @saved_article.destroy

    respond_to do |format|
      format.html { redirect_to saved_articles_url }
      format.json { head :ok }
    end
  end

end
