class AddConfirmedToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :confirmed, :integer
  end
end
