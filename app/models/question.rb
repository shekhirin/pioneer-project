class Question < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :question_tags
  has_many :tags, -> { distinct }, through: :question_tags
  has_many :replies, -> { order(created_at: :desc) }

  validates :body, presence: true

  def increase_views
    self.views += 1
    save!
  end
end
