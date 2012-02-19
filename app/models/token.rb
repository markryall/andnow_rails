class Token < ActiveRecord::Base
  validates :key, :presence => true
  validates :user_id, :presence => true
  belongs_to :user
end
