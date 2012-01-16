# RAW ARTICLE CLASS
# This class creates a RawArticle object, whose function is to hold all of the
# raw information we get from the nytimes API.
class RawArticle
  attr_accessor :section, :title, :abstract, :body, :url, :byline, :published_date, :updated_date, :kicker, :subhead, :material_type_facet, :des_facet, :org_facet, :per_facet, :geo_facet
  
end