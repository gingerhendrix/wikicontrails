class WikiVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki_page
end
