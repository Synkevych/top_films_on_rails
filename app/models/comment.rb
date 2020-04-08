class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, length: { minimum: 3}
  validates :body, presence: true, length: { minimum: 10}
  has_one_attached :avatar

#has_many :children, as: :commentable, class_name: 'Comment'
#belongs_to :commentable, polymorphic: true

end
