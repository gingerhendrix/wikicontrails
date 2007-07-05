require "digest/sha1"

class User < ActiveRecord::Base
  has_many :wiki_visits
  
  attr_accessible :username, :password
  
  def password=(pw)
    self.hashed_password = User.hash_password pw
  end
  
  def password
    "********"
  end
  
  def self.login(username, password)
    hashed_password = hash_password(password)
    find  :first, :conditions => ["username = ? and hashed_password = ?", username, hashed_password]
  end
  
  def self.hash_password(pw)
    Digest::SHA1.hexdigest(pw)
  end
end
