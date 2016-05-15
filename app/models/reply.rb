class Reply < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :reply, presence: true,
    length: {maximum: 140}
  

end
