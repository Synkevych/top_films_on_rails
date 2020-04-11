class Comment < ApplicationRecord
  belongs_to :user

  self.per_page = 5
  
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :body, presence: true, length: { minimum: 5}
  validates :user_id, presence: true
end
