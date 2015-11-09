class MentionsController < ApplicationController

  def index
    @mentions = Mention.all
  end

  def hold
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = '8dFq6kFt2UyrzUjLcza2bozh0'
      config.consumer_secret     = 'EINLOHvnOeYDkZY1ZFWQYtL2ZM6FSY67drXPOAqaXI8HGi6XBl'
      config.access_token        = '253712891-RweY3HWJtjRQacatizVio3gAOAxG3T5FNwYCG2fi'
      config.access_token_secret = 'YerIKljdjtXzXfSasE8OuJFchGip8nSVs5pSllszkuUWf'
    end
    @tweets = @client.mentions_timeline
    @tweets.each do |tweet|
      if ! Mention.exists?(:tweet_id => tweet.id)
        @path = tweet.user.profile_image_url.scheme + tweet.user.profile_image_url.host + tweet.user.profile_image_url.path
        Mention.create(tweet_id: tweet.id, owner: tweet.user.name, text: tweet.text, image_path: @path, tweet_created_at: tweet.created_at)
      end
    end
  end
end
