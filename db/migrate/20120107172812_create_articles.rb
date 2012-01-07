class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :abstract
      t.text :full_text
      t.string :url

      t.timestamps
    end
  end
end
