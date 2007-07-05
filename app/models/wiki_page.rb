class WikiPage < ActiveRecord::Base
  belongs_to :wiki
  has_many :wiki_visits
  
  def url
    self.wiki.base_url + self.name
   end
end
