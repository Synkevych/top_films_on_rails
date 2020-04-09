class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  attribute :role, :string, default: 'user'
  attribute :avatar, default: 'https://res.cloudinary.com/demo/image/upload/d_avatar.png/non_existing_id.png'
  
  has_many :aticles, dependent: :destroy

  validates :password, length: { minimum: 3}, :if => :password
end
