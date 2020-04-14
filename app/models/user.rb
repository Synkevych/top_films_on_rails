class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  before_save :downcase_email

  validates :username, presence: true, uniqueness: true
  attribute :role, :string, default: 'user'
  
  has_many :aticles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_secure_password

  validates :password, length: { minimum: 3}, :if => :password


def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #return new safe random token (string) 
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #Remember user in the db for use in a permanent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #return true if token = digest
   def authenticated?(attribute, token)
    digest = send("password_#{attribute}_token")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #forget user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  #Sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:password_reset_token,  User.digest(reset_token))
    update_attribute(:password_reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private

  def downcase_email
    self.email = email.downcase
  end

  #Creates and assigns an activation token and digest
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


end
