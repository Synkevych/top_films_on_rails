class User < ApplicationRecord
  has_one_attached :avatar

  has_secure_password
  validates :username, presence: true, uniqueness: true
  attribute :role, :string, default: 'user'
  # attribute :avatar, default: 'https://res.cloudinary.com/demo/image/upload/d_avatar.png/non_existing_id.png'
  
  has_many :aticles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 3}, :if => :password

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now 
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
