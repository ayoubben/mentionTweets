class Mention < ActiveRecord::Base
  has_one :comment
  validates_uniqueness_of :tweet_id
end