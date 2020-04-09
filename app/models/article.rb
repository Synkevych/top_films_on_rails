# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
  
  validates :image, presence: true
end
