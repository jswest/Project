class SharedArticle < ActiveRecord::Base
  belongs_to :article
  has_and_belongs_to_many :users, :uniq => true
  belongs_to :shared_by, :class_name => "User", :foreign_key => "shared_by"
end
