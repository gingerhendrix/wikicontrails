class CreateWikiVisits < ActiveRecord::Migration
  def self.up
    create_table :wiki_visits do |t|
      t.column :wiki_page_id, :integer
      t.column :user_id, :integer
      t.column :time_of_visit, :time
    end
  end

  def self.down
    drop_table :wiki_visits
  end
end
