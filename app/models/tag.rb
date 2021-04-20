class Tag < ApplicationRecord
  has_many :questions, through: :question_tags
end

