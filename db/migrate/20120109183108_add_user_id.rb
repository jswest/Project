class AddUserId < ActiveRecord::Migration
  def up
    add_column :articles, :user_id, :integer, :nil => false
  end

  def down
    remove_column :articles, :user_id
  end
end
