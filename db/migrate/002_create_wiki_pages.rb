class CreateWikiPages < ActiveRecord::Migration
  def self.up
    create_table :wiki_pages do |t|
      t.column :wiki_id, :integer
      t.column :name, :string #wikified name 
      t.column :title, :string #printable name
      
    end
  end

  def self.down
    drop_table :wiki_pages
  end
end
