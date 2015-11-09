class MentionsController < ApplicationController
  before_action :set_mention, only: [:show, :edit, :update, :destroy]

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

  # GET /mentions/1
  # GET /mentions/1.json
  def show
  end

  # GET /mentions/new
  def new
    @mention = Mention.new
  end

  # GET /mentions/1/edit
  def edit
  end

  # POST /mentions
  # POST /mentions.json
  def create
    @mention = Mention.new(mention_params)

    respond_to do |format|
      if @mention.save
        format.html { redirect_to @mention, notice: 'Mention was successfully created.' }
        format.json { render :show, status: :created, location: @mention }
      else
        format.html { render :new }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentions/1
  # PATCH/PUT /mentions/1.json
  def update
    respond_to do |format|
      if @mention.update(mention_params)
        format.html { redirect_to @mention, notice: 'Mention was successfully updated.' }
        format.json { render :show, status: :ok, location: @mention }
      else
        format.html { render :edit }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentions/1
  # DELETE /mentions/1.json
  def destroy
    @mention.destroy
    respond_to do |format|
      format.html { redirect_to mentions_url, notice: 'Mention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mention
      @mention = Mention.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mention_params
      params[:mention]
    end
end
