class RemoveUpdatedDateFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :updated_date
  end

  def down
    add_column :articles, :updated_date, :string
  end
end
