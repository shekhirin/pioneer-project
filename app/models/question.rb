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

  def rating
    gravity = 1.8
    hours_since_creation = (Time.now - self.created_at).hours
    views = self.views - 1
    replies = self.replies.count
    if replies > 0
      hours_since_last_reply = (Time.now - self.replies.max_by { |reply| reply.created_at }.created_at).hours
      views / (hours_since_creation + hours_since_last_reply) ** gravity
    else
      (views + replies) / (hours_since_creation) ** gravity
    end
  end
end
