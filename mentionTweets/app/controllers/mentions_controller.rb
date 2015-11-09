class MentionsController < ApplicationController

  def index
    @mentions = Mention.all
  end

  def hold
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
    @tweets = @client.mentions_timeline
    @tweets.each do |tweet|
      if ! Mention.exists?(:tweet_id => tweet.id)
        @url = 'http://' + tweet.user.profile_image_url.host + tweet.user.profile_image_url.path
        Mention.create(tweet_id: tweet.id, owner: tweet.user.name, text: tweet.text, image_path: @url, tweet_created_at: tweet.created_at)
      end
    end
  end
end
