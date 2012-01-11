class AddFirstParagraphToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :first_paragraph, :text
  end
end
