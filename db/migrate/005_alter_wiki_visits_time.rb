class AlterWikiVisitsTime < ActiveRecord::Migration
  def self.up
    remove_column :wiki_visits, :time_of_visit
    add_column :wiki_visits, :time_of_visit, :datetime
  end

  def self.down
    remove_column :wiki_visits, :time_of_visit  
    add_column :wiki_visits, :time_of_visit, :time
  end
end
