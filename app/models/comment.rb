class Comment < ApplicationRecord
  belongs_to :article
  validates :body, presence: true, length: { minimum: 10}

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

end
