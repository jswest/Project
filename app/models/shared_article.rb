class SharedArticle < ActiveRecord::Base
  belongs_to :article
  has_and_belongs_to_many :users, :uniq => true
  belongs_to :shared_by, :class_name => "User", :foreign_key => "shared_by"

  # Method to process the parameters produced by the new shared articles form
  def self.create_share(params)
    shared_article = SharedArticle.new
    shared_article.article_id = params[:article_id]
    shared_article.blurb = params[:blurb]
    shared_article.shared_by = User.find(params[:user_id])
    shared_with = params[:users].split(',').map(&:strip).map{|u| User.find_by_email(u)}
    shared_with.each{ |user| shared_article.users << user unless user.nil? }
    return shared_article
  end
end
