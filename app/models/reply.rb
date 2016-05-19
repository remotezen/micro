class Reply < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  default_scope->{order(created_at: :desc)} 
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :reply, presence: true,
    length: {maximum: 140}
  include PgSearch
  multisearchable :against => [:reply]
  paginates_per 15
  

end
