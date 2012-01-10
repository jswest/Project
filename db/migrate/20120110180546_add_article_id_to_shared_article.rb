class AddArticleIdToSharedArticle < ActiveRecord::Migration
  def change
    add_column :shared_articles, :article_id, :integer, :nil => false
  end
end
