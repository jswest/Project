class CreateSharedArticles < ActiveRecord::Migration
  def change
    create_table :shared_articles do |t|
      t.text :blurb

      t.timestamps
    end
  end
end
