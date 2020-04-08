class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username
  validates_uniqueness_of :username
  attribute :role, :string, default: 'user'
  has_many :aticles, dependent: :destroy

  mount_uploader :avatar_url, AvatarUploader
  attribute :avatar, default: 'https://res.cloudinary.com/demo/image/upload/d_avatar.png/non_existing_id.png'
end
