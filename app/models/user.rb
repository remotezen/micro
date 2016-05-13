class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy 
  
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  

  
  has_many :following, through: :active_relationships,
    source: :followed

=begin  
can omit the source key follower_id is implicit
=end
  has_many :followers, through: :passive_relationships, source: :follower
  
  attr_accessor :remember_token, :activation_token, :reset_token
  
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name,  presence: true,
    length: {maximum: 50}

  REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
    length: {maximum: 250},
    format: {with: EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
    validates :password, presence: true,
      length: {minimum: 6}, allow_nil: true
  has_secure_password
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  def following?(other)
    following.include?(other)
  end
  
  def feed
    Micropost.where("user_id = ?", id).includes(:user)
    
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end

  def remember 
    self.remember_token =  User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  
  def activate
    #update_columns only one hit on database
  #  update_attribute(:activated, true)
   # update_attribute(:activated_at, Time.zone.now)
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token =  User.new_token
    #update_columns only one hit on database
    #update_attribute(:reset_digest, User.digest(reset_token))
    #update_attribute(:reset_sent_at, Time.zone.now)
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
 
  
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST:
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  
  private
  def downcase_email
    self.email = email.downcase
  end
  
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)

  end

end