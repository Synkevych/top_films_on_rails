# frozen_string_literal: true

class Article < ApplicationRecord
  # has_one_attached :image
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true
  
  self.per_page = 5
  
end
