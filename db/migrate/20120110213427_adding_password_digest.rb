class AddingPasswordDigest < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, :nil => false
  end

  def down
  end
end
