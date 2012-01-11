class SavedArticle < ActiveRecord::Base
  belongs_to :article
  belongs_to :saved_by, :class_name => "User", :foreign_key => "saved_by"
end
