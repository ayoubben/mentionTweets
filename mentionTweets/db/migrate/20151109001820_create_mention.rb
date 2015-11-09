class CreateMention < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string :tweet_id, :limit => 8
      t.string :owner
      t.text   :text
      t.string :tweet_created_at
      t.string :image_path


      t.timestamps null: false
    end
    add_index :mentions, [ :tweet_id ], :unique => true
  end
end
