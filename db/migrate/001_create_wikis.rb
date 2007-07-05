class CreateWikis < ActiveRecord::Migration
  def self.up
    create_table :wikis do |t|
      
      t.column :name, :string
      t.column :homepage, :string
      t.column :base_url, :string
    end
  end

  def self.down
    drop_table :wikis
  end
end
