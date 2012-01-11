class AddingUserId < ActiveRecord::Migration
  def up
    add_column :saved_articles, :user_id, :integer, :nil => false
  end

  def down
    remove_column :saved_articles, :user_id
  end
end
