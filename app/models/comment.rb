class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  
  validates :body, presence: true, length: { minimum: 5}
  validates :user_id, presence: true 
end
