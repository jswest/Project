class AddSourceToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :source, :text
  end
end
