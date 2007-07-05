class AddInitialisationData < ActiveRecord::Migration
  def self.up
    user = User.create :username=>"ga", :password=>"password"
    wiki = Wiki.create :name => "Wikipedia (en)", :homepage=>"http://en.wikipedia.org", :base_url=>"http://en.wikipedia.org/wiki/"
    wiki_page = WikiPage.create :wiki_id => wiki.id, :name => "Smoke_rings", :title => "Smoke rings"
    wiki_visit = WikiVisit.create :wiki_page_id => wiki_page.id, :user_id => user.id, :time_of_visit => DateTime.now
  end

  def self.down
    User.delete_all
    Wiki.delete_all
    WikiPage.delete_all
    WikiVisit.delete_all
  end
end
