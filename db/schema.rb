# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 7) do

  create_table "users", :force => true do |t|
    t.column "username",        :string
    t.column "hashed_password", :string
  end

  create_table "wiki_pages", :force => true do |t|
    t.column "wiki_id", :integer
    t.column "name",    :string
    t.column "title",   :string
  end

  create_table "wiki_visits", :force => true do |t|
    t.column "wiki_page_id",  :integer
    t.column "user_id",       :integer
    t.column "time_of_visit", :datetime
  end

  create_table "wikis", :force => true do |t|
    t.column "name",     :string
    t.column "homepage", :string
    t.column "base_url", :string
  end

end
