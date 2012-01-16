require './lib/daemons/pantalaimon'
require './lib/daemons/kaisa'

def load_articles
  pantalaimon # Load NYTimes articles
  kaisa # Load MSNBC images
end