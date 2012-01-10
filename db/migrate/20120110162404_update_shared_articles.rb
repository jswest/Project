class UpdateSharedArticles < ActiveRecord::Migration
  def up
    add_column :shared_articles, :shared_by, :integer
    create_table :shared_articles_users, :id => false do |t|
      t.references :shared_article, :null => false
      t.references :user, :null => false
    end
    add_index(:shared_articles_users, [:shared_article_id, :user_id], :unique => true)
  end

  def down
    remove_column :shared_articles, :shared_by
    drop_table :shared_articles_users
  end
end
