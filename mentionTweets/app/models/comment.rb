class Comment < ActiveRecord::Base
  belongs_to :mention

  validates :text, length: { maximum: 140 }
  validates :mention_id, presence: true
end
