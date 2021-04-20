class Question < ApplicationRecord
  has_many :question_tags
  has_many :tags, through: :question_tags
  has_many :replies, -> { order(created_at: :desc) }

  validates :body, presence: true
end
