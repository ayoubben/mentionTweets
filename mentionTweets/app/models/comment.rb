class Comment < ActiveRecord::Base
  belongs_to :mention

  validates :mention_id, presence: true
end
