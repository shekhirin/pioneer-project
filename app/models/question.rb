class Question < ApplicationRecord
  has_many :tags, through: :question_tags
  has_many :replies
end
