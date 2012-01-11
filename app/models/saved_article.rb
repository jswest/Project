class SavedArticle < ActiveRecord::Base
  belongs_to :article
  belongs_to :user_id, :class_name => "User", :foreign_key => "user_id"
end
