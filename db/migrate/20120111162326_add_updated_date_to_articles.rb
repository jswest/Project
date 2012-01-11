class AddUpdatedDateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :updated_date, :string
  end
end
