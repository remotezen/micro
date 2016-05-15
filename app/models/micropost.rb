class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order(created_at: :desc) }
  has_many :replies, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence:true, length: {maximum:140}
  validate :picture_size
  def picture_size(*args)
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less then 5MB")
    end 
  end
end
