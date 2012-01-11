class AddingArticleIdToSavedArticles < ActiveRecord::Migration
  def up
    add_column :saved_articles, :article_id, :integer, :nil => false
  end

  def down
    remove_column :saved_articles, :article_id
  end
end
