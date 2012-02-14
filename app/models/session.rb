class Session < ActiveRecord::Base
  validates :description, :presence => true
  validates :user_id, :presence => true
  belongs_to :user

  def delete_duplicates
    Session.where([
      'description = ? AND start_time = ? AND user_id = ?',
      description,
      start_time,
      user.id
    ]).delete_all
  end

  def self.create_for user, params
    session = Session.new params
    session.user = user
    session.delete_duplicates
    session.save
  end
end
