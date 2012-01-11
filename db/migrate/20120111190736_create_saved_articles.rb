class CreateSavedArticles < ActiveRecord::Migration
  def change
    create_table :saved_articles do |t|

      t.timestamps
    end
  end
end
