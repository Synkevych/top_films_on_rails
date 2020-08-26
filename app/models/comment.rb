class Comment < ApplicationRecord
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :body, presence: true, length: { minimum: 5}
  validates :user_id, presence: true

  self.per_page = 3
end
