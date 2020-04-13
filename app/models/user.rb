class User < ApplicationRecord
  has_one_attached :avatar

  has_secure_password
  validates :username, presence: true, uniqueness: true
  attribute :role, :string, default: 'user'
  # attribute :avatar, default: 'https://res.cloudinary.com/demo/image/upload/d_avatar.png/non_existing_id.png'
  
  has_many :aticles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 3}, :if => :password

  #before_save :downcase_email

  # Sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_toke
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email 
  def send_password_reset_email
  #   generate_token(:password_reset_token)
  #   self.password_reset_sent_at = Time.zone.now 
  #   save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

end
